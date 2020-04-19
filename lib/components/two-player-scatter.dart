import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TwoPlayerScatter extends StatefulWidget {
  TwoPlayerScatter(this.title, this.tashWinMargins, this.thomWinMargins);

  final String title;
  final Map<int, int> tashWinMargins;
  final Map<int, int> thomWinMargins;

  @override
  _TwoPlayerScatterState createState() => _TwoPlayerScatterState();
}

class _TwoPlayerScatterState extends State<TwoPlayerScatter> {
  Widget build(BuildContext context) {
    List<ScatterSpot> scatterSpots = [
      ...makeScatter(widget.tashWinMargins, Colors.pink),
      ...makeScatter(widget.thomWinMargins, Colors.blue)
    ];

    return Scaffold(
      body: Center(
        child: ScatterChart(
          ScatterChartData(scatterSpots: scatterSpots),
        ),
      ),
    );
  }

  List<ScatterSpot> makeScatter(winMargin, Color color) {
    return winMargin.entries
        .map<ScatterSpot>((marginTally) => new ScatterSpot(
            marginTally.key.toDouble(), marginTally.value.toDouble(),
            color: color))
        .toList();
  }
}
