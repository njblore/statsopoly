import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartCard extends StatelessWidget {
  PieChartCard(this.title, this.tashWins, this.thomWins, this.ties);

  final double tashWins;
  final double thomWins;
  final double ties;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(this.title),
            PieChart(
              PieChartData(
                  sections: [
                    PieChartSectionData(
                        value: this.tashWins,
                        color: Colors.pink,
                        title: this.tashWins.toString()),
                    PieChartSectionData(
                        value: this.thomWins,
                        color: Colors.blue,
                        title: this.thomWins.toString()),
                    PieChartSectionData(
                        value: this.ties,
                        color: Colors.yellow[50],
                        title: this.ties.toString(),
                        titleStyle: TextStyle(color: Colors.black38))
                  ],
                  borderData: FlBorderData(show: false),
                  pieTouchData: PieTouchData(enabled: true)),
            )
          ],
        ),
      ),
    );
  }
}
