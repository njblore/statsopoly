import 'package:flutter/material.dart';

final Container loadingPage = Container(
  child: Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Text("Loading ...",
            style: TextStyle(
                color: Colors.brown[800],
                fontSize: 30,
                fontFamily: "AmaticSC",
                fontWeight: FontWeight.bold)),
      ),
      SizedBox(
        height: 100,
        width: 100,
        child: CircularProgressIndicator(
          strokeWidth: 8,
          backgroundColor: Colors.transparent,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.brown[800]),
        ),
      ),
    ],
  )),
);
