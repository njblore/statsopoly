import 'package:flutter/material.dart';

class Mars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[900],
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
                  0.1,
                  0.3,
                  0.6,
                  0.9
                ],
                colors: [
                  Colors.red[900],
                  Colors.deepOrange[700],
                  Colors.deepOrange[600],
                  Colors.orange[800]
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
