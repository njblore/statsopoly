import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MultiplayerPlayerPieCard extends StatefulWidget {
  MultiplayerPlayerPieCard(
    this.title,
  );

  final String title;

  @override
  _MultiplayerPlayerPieCardState createState() =>
      _MultiplayerPlayerPieCardState();
}

class _MultiplayerPlayerPieCardState extends State<MultiplayerPlayerPieCard> {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(widget.title),
            PieChart(
              PieChartData(
                sections: showingSections(),
                borderData: FlBorderData(show: false),
                pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                  setState(() {
                    if (pieTouchResponse.touchInput is FlLongPressEnd ||
                        pieTouchResponse.touchInput is FlPanEnd) {
                      touchedIndex = -1;
                    } else {
                      touchedIndex = pieTouchResponse.touchedSectionIndex;
                    }
                  });
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 70 : 60;
      switch (i) {
        case 0:
          return PieChartSectionData(
            value: 1,
            color: Colors.pink,
            title: 1.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 1:
          return PieChartSectionData(
            value: 1,
            color: Colors.blue,
            title: 1.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 2:
          return PieChartSectionData(
            value: 1,
            color: Colors.yellow[50],
            title: 1.toString(),
            titleStyle: TextStyle(
              color: Colors.black38,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
            radius: radius,
          );
        default:
          return null;
      }
    });
  }
}
