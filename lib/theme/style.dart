import 'package:flutter/material.dart';

final ThemeData AppThemeData = ThemeData(
  primaryColor: Color(0xff80b9a8),
  primaryTextTheme: TextTheme(
      headline: TextStyle(
          fontFamily: 'AmaticSC',
          color: Colors.brown[800],
          fontWeight: FontWeight.bold,
          fontSize: 80),
      title: TextStyle(
          fontFamily: 'AmaticSC',
          color: Colors.brown[800],
          fontWeight: FontWeight.bold,
          fontSize: 50),
      subtitle: TextStyle(
          fontFamily: 'AmaticSC',
          color: Colors.brown[800],
          fontWeight: FontWeight.bold,
          fontSize: 20),
      body1: TextStyle(
          fontFamily: 'JosefinSlab',
          fontWeight: FontWeight.normal,
          fontSize: 15,
          color: Colors.brown[900]),
      caption: TextStyle(
          fontFamily: 'JosefinSlab',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white70)),
);
