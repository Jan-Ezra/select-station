import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  AppTextField({ 
    Key key,
    this.hintText,
    this.labelText,
    this.validator,
    this.controller,
    this.icon,
  }) : super(key: key);

  final String hintText;
  final String labelText;
  final Function(String) validator;
  final TextEditingController controller;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        icon: icon,
        hintText: hintText ?? '',
        labelText: labelText ?? "",
      ),
      validator: validator,
      controller: controller,
    );
  }
}