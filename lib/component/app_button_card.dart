import 'package:flutter/material.dart';

class AppButtonCard extends StatelessWidget {
  AppButtonCard({ 
    Key key,
    this.onTap,
    this.elevation,
    this.borderRadius,
    this.buttonColor,
    this.titleAlignment,
    this.title,
    this.titleFontSize,
    this.titleColor,
  }) : super(key: key);

  final VoidCallback onTap;
  final double elevation;
  final double borderRadius;
  final Color buttonColor;
  final Alignment titleAlignment;
  final String title;
  final double titleFontSize;
  final Color titleColor;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
        width: double.infinity,
        child: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            elevation: elevation ?? 0,
            padding: EdgeInsets.only(top: 15, bottom: 15, right: 15, left: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            backgroundColor: buttonColor ?? Colors.black,
          ),
          child: Align(
            alignment: titleAlignment,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleFontSize ?? 14, color: titleColor ?? Colors.white),
            ),
          ),
        ),
      );
  }
}