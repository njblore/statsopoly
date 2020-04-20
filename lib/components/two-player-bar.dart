import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:scoreboards_app/models/agricola-background.dart';
import 'package:scoreboards_app/models/indicator.dart';

class TwoPlayerBar extends StatefulWidget {
  TwoPlayerBar(this.title, this.tashWinMargins, this.thomWinMargins);

  final String title;
  final Map<int, int> tashWinMargins;
  final Map<int, int> thomWinMargins;

  @override
  _TwoPlayerBarState createState() => _TwoPlayerBarState();
}

class _TwoPlayerBarState extends State<TwoPlayerBar> {
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          iconSize: 40,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.lightGreen[100],
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Container(
            decoration: agricolaBackground,
          ),
          Container(
            height:
                MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
            color: Colors.transparent,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: <Widget>[
                      Text(
                        widget.title,
                        style: Theme.of(context).primaryTextTheme.title,
                      ),
                    ],
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.5,
                        minWidth: MediaQuery.of(context).size.width * 0.8),
                    child: BarChart(
                      BarChartData(
                        titlesData: FlTitlesData(
                            bottomTitles: SideTitles(
                              showTitles: true,
                              interval: 2,
                              getTitles: (title) => title.toStringAsFixed(0),
                            ),
                            leftTitles: SideTitles(
                                getTitles: (title) => title.toStringAsFixed(0),
                                showTitles: true)),
                        backgroundColor: Colors.white24,
                        borderData: FlBorderData(show: false),
                        barGroups: makeBarGroups(),
                        gridData: FlGridData(show: false),
                        axisTitleData: FlAxisTitleData(
                            bottomTitle: AxisTitle(
                                titleText: 'Win Margin', showTitle: true),
                            show: true,
                            leftTitle: AxisTitle(
                                titleText: 'Frequency', showTitle: false)),
                      ),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Indicator(
                          color: Colors.pink[300],
                          text: 'Tash',
                          isSquare: false,
                          size: 16,
                          textColor: Colors.white70,
                        ),
                        Indicator(
                          color: Colors.green[700],
                          text: 'Thom',
                          isSquare: false,
                          size: 16,
                          textColor: Colors.white70,
                        ),
                      ])
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> makeBarGroups() {
    var maxMargin = max(widget.tashWinMargins.keys.reduce(max),
        widget.thomWinMargins.keys.reduce(max));

    List<BarChartGroupData> barGroups = [];

    for (var i = 0; i <= maxMargin; i++) {
      var tashFrequency = widget.tashWinMargins[i] != null
          ? widget.tashWinMargins[i].toDouble()
          : 0.0;
      var thomFrequency = widget.thomWinMargins[i] != null
          ? widget.thomWinMargins[i].toDouble()
          : 0.0;

      barGroups.add(makeGroupData(i, tashFrequency, thomFrequency));
    }

    return barGroups;
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 1, x: x, barRods: [
      BarChartRodData(
        y: y1,
        color: Colors.pink[300],
        width: 2,
      ),
      BarChartRodData(
        y: y2,
        color: Colors.green[700],
        width: 2,
      ),
    ]);
  }
}
