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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/catanposter.png'),
                fit: BoxFit.cover)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Column(children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      border: Border(
                          top: BorderSide(color: Colors.pink[100], width: 1.5),
                          bottom:
                              BorderSide(color: Colors.pink[100], width: 1.5)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        children: <Widget>[
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
                                fontSize: 60,
                                fontFamily: 'JosefinSlab'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
              Align(
                alignment: Alignment(-0.7, 0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/mars');
                  },
                  child: Stack(
                      overflow: Overflow.visible,
                      alignment: Alignment.center,
                      children: [
                        Material(
                          elevation: 0.0,
                          shape: CircleBorder(),
                          clipBehavior: Clip.antiAlias,
                          child: Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/marsart.jpg'),
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.8),
                                      BlendMode.dstATop),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.centerRight),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100.0)),
                              border: Border.all(
                                color: Colors.white70,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                blurRadius: 20.0,
                                spreadRadius: 5.0,
                                offset: Offset(
                                  0.0,
                                  0.0,
                                ),
                              )
                            ]),
                            child: Image(
                              image: AssetImage('assets/marsheader.png'),
                              width: 150,
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              Align(
                alignment: Alignment(-0.7, 0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/agricola');
                    },
                    child: Stack(
                        overflow: Overflow.visible,
                        alignment: Alignment.center,
                        children: [
                          Material(
                            elevation: 0.0,
                            shape: CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: Container(
                              width: 120.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/agricola.jpg'),
                                    colorFilter: new ColorFilter.mode(
                                        Colors.black.withOpacity(0.8),
                                        BlendMode.dstATop),
                                    fit: BoxFit.fitHeight,
                                    alignment: Alignment.centerLeft),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100.0)),
                                border: Border.all(
                                  color: Colors.white70,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            child: Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 20.0,
                                  spreadRadius: 5.0,
                                  offset: Offset(
                                    0.0,
                                    0.0,
                                  ),
                                )
                              ]),
                              child: Image(
                                  image:
                                      AssetImage('assets/agricolaheader.png'),
                                  width: 150),
                            ),
                          ),
                        ])),
              ),
            ]),
      ),
    ));
  }
}
