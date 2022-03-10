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

class AppTextField2 extends StatelessWidget {
  AppTextField2({
    Key key,
    this.hintText,
    this.hintStyle,
    this.bgColor,
    this.onChange,
    this.textInputType = TextInputType.name,
    this.controller,
    this.onTap,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.words,
    this.icon,
  }) : super(key: key);

  final String hintText;
  final TextStyle hintStyle;
  final Color bgColor;
  final Function(String) onChange;
  final Function onTap;
  final TextInputType textInputType;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;
  final enabled;
  final Widget icon;

  final TextEditingController _inTernalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        onTap: onTap,
        enabled: enabled,
        autocorrect: false,
        onChanged: onChange,
        controller: controller ?? _inTernalController,
        keyboardType: textInputType,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(

          prefixIcon: icon,
          hintStyle: hintStyle,
          fillColor: bgColor,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: hintText ?? '',
          contentPadding: EdgeInsets.only(left: 10, right: 10, top: 15,),
        ),
      ),
    );
  }
}
