import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({Key key, this.subtitle}) : super(key: key);
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff743bbc))
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Container(
              width: double.infinity,
              child: new Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  letterSpacing: 3
                ),
              ),
            ),
          )
        ],
      ),
    ) ;
  }
}