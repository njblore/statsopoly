import 'package:flutter/material.dart';

class Agricola extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[300],
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
        ),
        body: Center(
            child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.2,
                  0.5,
                  0.8,
                  0.9
                ],
                colors: [
                  Colors.orange[300],
                  Colors.amber[200],
                  Colors.amber[100],
                  Colors.green[100]
                ]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                child: Text('Chart it'),
                onPressed: () {
                  // Navigate to the second screen when tapped.
                },
              )
            ],
          ),
        )));
  }
}
