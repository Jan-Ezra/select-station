
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:select_station/component/app_button_card.dart';
import 'package:select_station/component/app_text_field.dart';
import 'package:select_station/pages/login/login_controller.dart';


class LoginPage extends StatelessWidget {
  
  final LoginController logCon = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: logCon.formKey,
              child: Column(
                children: [
                  AppTextField(
                    hintText: "Input your mobile number*",
                    labelText: "Mobile Number",
                    controller: logCon.mobileNumberController,
                    icon: Icon(Icons.phone_android),
                    validator: (String value){
                      if(value.isEmpty){
                        return "Please input your mobile number";
                      }
                    },
                  ),
                  AppTextField(
                    hintText: "Input password*",
                    labelText: "Password",
                    icon: Icon(Icons.lock),
                    controller: logCon.passwordController,
                    validator: (String value){
                      if(value.isEmpty){
                        return "Please input your password";
                      }
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: AppButtonCard(
                      borderRadius: 10,
                      elevation: 1.0,
                      buttonColor: Colors.black,
                      titleAlignment: Alignment.center,
                      titleColor: Colors.white,
                      titleFontSize: 24.0,
                      title: "Login",
                      onTap: () => logCon.login()
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      
    );
  }
}