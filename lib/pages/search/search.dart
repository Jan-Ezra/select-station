import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:select_station/component/app_app_bar.dart';
import 'package:select_station/component/app_list_tile.dart';
import 'package:select_station/component/app_text_field.dart';
import 'package:select_station/model/StationModel.dart';
import 'package:select_station/pages/location/station_controller.dart';

class SearchStation extends StatefulWidget {
  SearchStation({ 
    Key key 
  }) : super(key: key);

  @override
  _SearchStationState createState() => _SearchStationState();
}

class _SearchStationState extends State<SearchStation> {
  final StationController staCon = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          title: "Search Station",
          actions: [
            IconButton(
              icon: Icon(Icons.close), 
              onPressed: (){
                Get.back();
              }
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            height: 100,
            color: Color(0xff743bbc),
            child: Column(
              children: [
                Align(
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
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: AppTextField2(
                    bgColor: Colors.white,
                    controller: staCon.searchStation,
                    enabled: true,
                    hintText: "Seach",
                    icon: Icon(Icons.search),
                    onChange: (value){
                      // staCon.searchFunction(value);
                      List<dynamic> newArray = [];
                      StationModel stationOldData = StationModel({});
                      stationOldData.station = staCon.stationModel.station;
                      staCon.filteredList.station = staCon.stationModel.station;
                      if(value.length > 0){
                        staCon.isFiltered.value = true;
                        for (int i = 0; i < staCon.filteredList.station.length; i++) {
                          if (staCon.filteredList.station[i]['name'].toLowerCase().contains(value.toLowerCase())) {
                            newArray.add(staCon.filteredList.station[i]);
                          }
                        }
                        staCon.filteredList.station = newArray;
                        print(staCon.filteredList.station);
                      }else{
                        staCon.isFiltered.value = false;
                        staCon.stationModel = stationOldData;
                      }
                      setState(() {});
                    },
                    
                  ),
                ),
              ],
            ),
          ),
          Obx(()=>Container(
            height: MediaQuery.of(context).size.height / 1.3,
            child: !staCon.isFiltered.value ? ListView.builder(
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
                      if(value != null){
                        staCon.onChangeStation(value, index);
                      }else{
                        staCon.onBackToList();
                      }
                    },
                  ),
                ));
              }
            ) : ListView.builder(
              itemCount: staCon.filteredList.station.length,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return Obx(()=> GestureDetector(
                  onTap: (){
                    staCon.onChangeStation(index, index);
                  },
                  child: CustomListTile(
                    title: staCon.filteredList.station[index]['name'],
                    subtitle: staCon.filteredList.station[index]['distance'].toStringAsFixed(2) + " km away from you",
                    value: index,
                    groupValue: !staCon.isSelected.value ? -1 : staCon.selectedRadio.value,
                    onChanged: (value){
                      if(value != null){
                        staCon.onChangeStation(value, index);
                      }else{
                        staCon.onBackToList();
                      }
                    },
                  ),
                ));
              }
            ),
          ))
        ],
      ),
      
    );
  }
}