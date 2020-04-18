import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TwoPlayerPieCard extends StatefulWidget {
  TwoPlayerPieCard(this.title, this.tashWins, this.thomWins, this.ties);
  final double tashWins;
  final double thomWins;
  final double ties;
  final String title;

  @override
  _TwoPlayerPieCardState createState() => _TwoPlayerPieCardState();
}

class _TwoPlayerPieCardState extends State<TwoPlayerPieCard> {
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
            value: widget.tashWins,
            color: Colors.pink,
            title: widget.tashWins.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 1:
          return PieChartSectionData(
            value: widget.thomWins,
            color: Colors.blue,
            title: widget.thomWins.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 2:
          return PieChartSectionData(
            value: widget.ties,
            color: Colors.yellow[50],
            title: widget.ties.toString(),
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
