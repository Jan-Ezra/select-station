import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:select_station/model/StationModel.dart';
import 'package:select_station/pages/login/login_controller.dart';
import 'package:intl/intl.dart';

class StationController extends GetxController{
  final LoginController logCon = Get.find();
  Rx<LatLng> stationLocation = LatLng(0, 0).obs;
  Rx<LatLng> currentLocation = LatLng(0, 0).obs;
  var stationData = Map<dynamic,dynamic>().obs;
  var isLoading = true.obs;
  String accessToken = "";
  StationModel stationModel = StationModel({});
  StationModel filteredList = StationModel({});
  var isFiltered = false.obs;
  CameraPosition initialCameraPosition;
  var isSelected = false.obs;
  var selectedRadio = 0.obs;
  Completer<GoogleMapController> mapController = Completer();
  Marker origin;
  TextEditingController searchStation = TextEditingController(text: "");




  @override
  void onInit() {
    stationLoading();
    super.onInit();

  }
  
  @override
  void onClose() {
    super.onClose();
  }

  void stationLoading() async {
    try {
      isLoading(true);
      currentLocation.value =  LatLng(logCon.userCoordinates.value.latitude, logCon.userCoordinates.value.longitude);
      var stationList = await getStationList();
      if(stationList != null){
      }
    } finally {
      isLoading(false);
    }
  }

  void onMapCreated(GoogleMapController controller) {
    return mapController.complete(controller);
  }

  void addMarker(LatLng pos) async {
    currentLocation.value = pos;
    origin = Marker(
      markerId: MarkerId(""),
      infoWindow: InfoWindow(title:""),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: currentLocation.value,
    );

    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 192.8334901395799,
        target: currentLocation.value,
        zoom: 14)
      )
    );
    
  }

  getInitialPosition(coordinates){
    initialCameraPosition = CameraPosition(
      target: LatLng(coordinates.latitude, coordinates.longitude),
      zoom: 16,
    );

    return initialCameraPosition;
  }

  getStationList() async {
    var url = Uri.parse('https://staging.api.locq.com/ms-fleet/station?page=1&perPage=20&isPlcOnboarded=true&platformType=plc');
    var response = await http.get(
      url,
    );

    var data = jsonDecode(response.body);
    if(data['message'] == "Station/s successfully retrieved"){
      stationModel.station = data['data']['stations'];
      stationModel.station.forEach((doc) {
        var distance = Geolocator.distanceBetween(logCon.userCoordinates.value.latitude, logCon.userCoordinates.value.longitude, doc['latitude'], doc['longitude']);
        doc['distance'] = distance * 0.001;
      });
      stationModel.station.sort((a,b) => a['distance'].compareTo(b['distance']));
    }else{
      Get.snackbar("Error", data['message'], duration: Duration(seconds: 2), backgroundColor: Colors.black, colorText: Colors.white);
    }
  }

  onChangeStation(value, index){
    isSelected.value = true;
    selectedRadio.value = value;
    stationLocation.value = LatLng(stationModel.station[index]['latitude'],stationModel.station[index]['longitude']);
    stationData.value = stationModel.station[index];
    addMarker(stationLocation.value);

  }

  onBackToList(){
    isSelected.value = false;
    addMarker(LatLng(logCon.userCoordinates.value.latitude, logCon.userCoordinates.value.longitude));

  }

  String displayText(String open, String close){
    String result = "";

    if(open == close){
      result = "Open 24 hours";
    }else{
      result = DateFormat.jm().format(DateFormat("hh:mm:ss").parse(open)) + " - " + DateFormat.jm().format(DateFormat("hh:mm:ss").parse(close));
    }

    return result;

  }

  searchFunction(value){
    List<dynamic> newArray = [];
    StationModel stationOldData = StationModel({});
    stationOldData.station = stationModel.station;
    filteredList.station = stationModel.station;
    if(value.length > 0){
      isFiltered.value = true;
      for (int i = 0; i < filteredList.station.length; i++) {
        if (filteredList.station[i]['name'].toLowerCase().contains(value.toLowerCase())) {
          newArray.add(filteredList.station[i]);
        }
      }
      filteredList.station = newArray;
    }else{
      isFiltered.value = false;
      stationModel = stationOldData;
    }
  }

  
}