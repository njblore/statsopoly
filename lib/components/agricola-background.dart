import 'package:flutter/material.dart';

final BoxDecoration agricolaBackground = BoxDecoration(
  image: DecorationImage(
      alignment: Alignment.centerRight,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
      image: AssetImage('assets/agPosterPlain.png'),
      fit: BoxFit.cover),
);
