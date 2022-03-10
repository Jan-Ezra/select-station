
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:select_station/component/app_app_bar.dart';
import 'package:select_station/component/app_button_card.dart';
import 'package:select_station/component/app_loading.dart';
import 'package:select_station/component/app_text_field.dart';
import 'package:select_station/pages/location/station_controller.dart';
import 'package:select_station/pages/login/login_controller.dart';


class LoginPage extends StatelessWidget {
  final LoginController logCon = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: CustomAppBar(
                title: "Search Station",
                actions: [],
              ),
            ),
            body: Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Form(
                    key: logCon.formKey,
                    child: Column(
                      children: [
                        AppTextField2(
                          bgColor: Colors.grey[300],
                          controller: logCon.mobileNumberController,
                          enabled: true,
                          hintText: "Email",
                          icon: Icon(Icons.phone_android),
                        ),
                        SizedBox(height: 20,),
                        AppTextField2(
                          bgColor: Colors.grey[300],
                          controller: logCon.passwordController,
                          enabled: true,
                          hintText: "Password",
                          icon: Icon(Icons.lock),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: AppButtonCard(
                            borderRadius: 10,
                            elevation: 1.0,
                            buttonColor: Color(0xff743bbc),
                            titleAlignment: Alignment.center,
                            titleColor: Colors.white,
                            titleFontSize: 20.0,
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
          ),
          Obx((){
            if(logCon.loader.value){
              return AppLoading(
                subtitle: 'Loading ...',
              );
            }
            return const  SizedBox();
          })
        ],
      ),
    );
  }
}