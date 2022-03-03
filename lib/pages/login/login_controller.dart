import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:select_station/pages/location/station.dart';

class LoginController extends GetxController{

  final formKey = GlobalKey<FormState>();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login() async {
    if(formKey.currentState.validate()){
      Map<String, dynamic> requestPayload = {
        'mobile': mobileNumberController.text, 
        'password': passwordController.text,
      };

      var url = Uri.parse('https://stable-api.pricelocq.com/mobile/v2/sessions');
      var response = await http.post(
        url, 
        body: jsonEncode(requestPayload)
      );
      
      var data = jsonDecode(response.body);
      if(data['status'] == "failed"){
        
      }
      Get.to(() => Station());

      
    }
    

  }
  
}