import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;
  final double fontSize;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size,
    this.fontSize,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.blueGrey[200],
            ),
            padding: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
                    color: color,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  text,
                  style: TextStyle(
                      fontSize: this.fontSize,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      fontFamily: 'AmaticSC'),
                )
              ],
            )));
  }
}
