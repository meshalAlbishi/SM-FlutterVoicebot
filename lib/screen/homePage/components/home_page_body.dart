import 'package:flutter/material.dart';

createBody(String text){
  return Container(
    padding: EdgeInsets.fromLTRB(30.0, 0, 0, 500.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
        )
      ],
    ),
  );
}