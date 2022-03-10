import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:select_station/component/app_app_bar.dart';
import 'package:select_station/component/app_list_tile.dart';
import 'package:select_station/pages/location/station_controller.dart';
import 'package:select_station/pages/login/login_controller.dart';
import 'package:select_station/pages/search/search.dart';

class Station extends StatelessWidget {

  final StationController staCon = Get.put(StationController());
  final LoginController logCon = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          title: "Search Station",
          actions: [
            IconButton(
              icon: Icon(Icons.search), 
              onPressed: (){
                Get.to(() => SearchStation());
              }
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              height: 40,
              color: Color(0xff743bbc),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Which PriceLOCQ station will you likely to visit?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  height: (MediaQuery.of(context).size.height) - 136,
                  child: Obx(()=>
                    GoogleMap(
                      myLocationButtonEnabled: false,
                      onTap: (value) => staCon.addMarker(staCon.currentLocation.value),
                      // zoomControlsEnabled: false,
                      initialCameraPosition: staCon.getInitialPosition(staCon.currentLocation.value),
                      onMapCreated: staCon.onMapCreated,
                      myLocationEnabled: true,
                      markers: {
                        if (staCon.origin != null) staCon.origin,
                      },
                    ),
                  )
                  
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.5,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0), 
                        topRight: Radius.circular(20.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child:Obx(() {
                      if(staCon.isLoading.value){
                        return Center(child: CircularProgressIndicator());
                      } else {
                        // return Container();
                        return !staCon.isSelected.value ? Column(
                          children: [
                            Container(
                              height: 50,
                              padding: const EdgeInsets.only(left:10, right: 10, top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Nearby Stations",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: (){

                                    }, child: Text(
                                      "Done",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  )
                                ],
                              ),
                            ), 
                            Container(
                              height: (MediaQuery.of(context).size.height / 4),
                              child: ListView.builder(
                                itemCount: staCon.stationModel.station.length,
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (context, index) {
                                  return Obx(()=> GestureDetector(
                                    onTap: (){
                                      staCon.onChangeStation(index, index);
                                    },
                                    child: CustomListTile(
                                      title: staCon.stationModel.station[index]['name'],
                                      subtitle: staCon.stationModel.station[index]['distance'].toStringAsFixed(2) + " km away from you",
                                      value: index,
                                      groupValue: !staCon.isSelected.value ? -1 : staCon.selectedRadio.value,
                                      onChanged: (value){
                                        staCon.onChangeStation(value, index);
                                      },
                                    ),
                                  ));
                                }
                              ),
                            ),
                          ],
                        ) : Column(
                          children: [
                            Container(
                              height: 60,
                              padding: const EdgeInsets.only(left:10, right: 10, top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: (){
                                      staCon.onBackToList();
                                    },
                                    child: Text(
                                      "Back to list",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: (){
                                      staCon.onBackToList();
                                    }, 
                                    child: Text(
                                      "Done",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  ),
                                ],
                              ),
                            ), 
                            Container(
                              height: (MediaQuery.of(context).size.height / 4),
                              padding: const EdgeInsets.only(left:20, right: 20),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20,),
                                  Text(
                                    staCon.stationData.value['name'].toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                    staCon.stationData.value['address'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    staCon.stationData.value['city'].toUpperCase() + ", " + staCon.stationData.value['province'].toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.time_to_leave),
                                          Text(staCon.stationData.value['distance'].toStringAsFixed(2) + " km away")
                                        ],
                                      ),
                                      SizedBox(width: 20,),
                                      Row(
                                        children: [
                                          Icon(Icons.timer),
                                          Text(staCon.displayText(staCon.stationData.value['opensAt'], staCon.stationData.value['closesAt']))
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    }
                    )
                  ),
                ),
              ],
            ),
            
          ],
        ),
      )
    );
  }
}