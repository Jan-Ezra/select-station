import 'package:flutter/material.dart';

import 'app_text_field.dart';


class CustomAppBar extends StatelessWidget {
  const CustomAppBar({ 
    Key key,
    this.title,
    this.actions,
    this.subtitle = "",
    this.controller,
    this.onChange,
    this.hintText,
    this.icon,

  }) : super(key: key);

  final String title;
  final List<Widget> actions;
  final String subtitle;
  final TextEditingController controller;
  final String hintText;
  final Function(String) onChange;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff743bbc),
      automaticallyImplyLeading: false,
      elevation: 0.0,
      toolbarHeight: 60,
      title: Container(
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
      actions: actions,
    );
  }
}