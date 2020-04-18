import 'package:flutter/material.dart';
import 'package:scoreboards_app/screens/agricola-home.dart';
import 'package:scoreboards_app/screens/terraforming-home.dart';
import 'package:scoreboards_app/theme/style.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/agricola': (context) => Agricola(),
        '/mars': (context) => Mars(),
      },
      theme: AppThemeData,
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.4, 0.7, 0.9],
              colors: [Colors.pink[300], Colors.amber[300], Colors.amber[200]]),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Column(children: <Widget>[
                  Text(
                    "--------- Battle ---------",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PoiretOne',
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "--- of the Scores ---",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PoiretOne',
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "Statsopoly",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 65,
                        fontFamily: 'JosefinSlab'),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Image(
                        image: AssetImage('data/marsheader.png'),
                        width: 180.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/mars');
                        },
                        child: Material(
                          elevation: 5.0,
                          shape: CircleBorder(),
                          clipBehavior: Clip.antiAlias,
                          child: Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: new BoxDecoration(
                              color: const Color(0xff7c94b6),
                              image: new DecorationImage(
                                  image: AssetImage('data/marsart.jpg'),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.centerRight),
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(100.0)),
                              border: new Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/agricola');
                          },
                          child: Material(
                            elevation: 5.0,
                            shape: CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: Container(
                              width: 120.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('data/agricola.jpg'),
                                    fit: BoxFit.fitHeight,
                                    alignment: Alignment.centerLeft),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100.0)),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Image(
                          image: AssetImage('data/agricolaheader.png'),
                          width: 180.0,
                        )
                      ]))
            ]),
      ),
    ));
  }
}
