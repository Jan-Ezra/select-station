import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({ 
    Key key,
    this.title,
    this.subtitle, 
    this.onTap,
    this.onChanged,
    this.value,
    this.groupValue,
    this.activeColor,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final dynamic value;
  final dynamic groupValue;
  final Function(dynamic) onChanged;
  final Color activeColor;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: new Text(title),
      subtitle: new Text(subtitle),
      trailing: Radio(
        toggleable: true,
        value: value,
        groupValue: groupValue,
        activeColor: activeColor,
        onChanged: onChanged,
      ),
      
    );
  }
}