import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:select_station/pages/location/station.dart';
import 'package:select_station/pages/location/station_controller.dart';

class LoginController extends GetxController{
  Rx<LatLng> userCoordinates = LatLng(0, 0).obs;
  var loader = false.obs;
  final formKey = GlobalKey<FormState>();
  TextEditingController mobileNumberController = TextEditingController(text: "+639998520424");
  TextEditingController passwordController = TextEditingController(text: "111111");

  login() async {
    if(formKey.currentState.validate()){
      loader.value = true;
      var url = Uri.parse('https://staging.api.locq.com/ms-profile/user/login');
      var response = await http.post(
        url, 
        body: {
          "mobileNumber": mobileNumberController.text,
          "password": passwordController.text,
          "profileType": "plc"
        }
      );
      
      var data = jsonDecode(response.body);
      if(data['message'] == "User successfully logged in"){
        loader.value = true;
        determinePosition().then((position){
          userCoordinates.value = LatLng(position.latitude, position.longitude);
        }).then((value){
          loader.value = false;
          Get.to(() => Station());
        });
        
      }else{
        loader.value = false;
        Get.snackbar("Error", data['message'], duration: Duration(seconds: 2), backgroundColor: Colors.black, colorText: Colors.white);
      }
    }
  }
  
  Future<Position> determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
  }

}