import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:scoreboards_app/models/agricola-background.dart';
import 'package:scoreboards_app/models/indicator.dart';

class TwoPlayerWinsBar extends StatefulWidget {
  TwoPlayerWinsBar(this.title, this.tashWinMargins, this.thomWinMargins);

  final String title;
  final Map<int, int> tashWinMargins;
  final Map<int, int> thomWinMargins;

  @override
  _TwoPlayerWinsBarState createState() => _TwoPlayerWinsBarState();
}

class _TwoPlayerWinsBarState extends State<TwoPlayerWinsBar> {
  Widget build(BuildContext context) {
    var thomWinAvg =
        widget.thomWinMargins.keys.fold(0, (total, margin) => total += margin) /
            widget.tashWinMargins.keys.length;
    var tashWinAvg =
        widget.tashWinMargins.keys.fold(0, (total, margin) => total += margin) /
            widget.tashWinMargins.keys.length;
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        color: Colors.lightGreen[200]),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                              width: 40,
                              height: 40,
                              child: Center(
                                child: Text(tashWinAvg.toStringAsFixed(0),
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .subtitle),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.pink[300],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              )),
                          Text(
                            "<- Average ->",
                            style: Theme.of(context).primaryTextTheme.subtitle,
                          ),
                          Container(
                              width: 40,
                              height: 40,
                              child: Center(
                                child: Text(thomWinAvg.toStringAsFixed(0),
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .subtitle),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.teal[400],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              )),
                        ]),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.5,
                        minWidth: MediaQuery.of(context).size.width * 0.8),
                    child: Container(
                      padding: EdgeInsets.only(right: 10, top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        color: Colors.white70,
                      ),
                      child: BarChart(
                        BarChartData(
                          titlesData: FlTitlesData(
                              bottomTitles: SideTitles(
                                textStyle:
                                    Theme.of(context).primaryTextTheme.body2,
                                showTitles: true,
                                interval: 2.0,
                                rotateAngle: 90,
                                getTitles: (title) => title.toStringAsFixed(0),
                              ),
                              leftTitles: SideTitles(
                                  textStyle:
                                      Theme.of(context).primaryTextTheme.body2,
                                  margin: 0.5,
                                  getTitles: (title) =>
                                      title.toStringAsFixed(0),
                                  showTitles: true)),
                          backgroundColor: Colors.transparent,
                          borderData: FlBorderData(show: false),
                          barGroups: makeBarGroups(),
                          gridData: FlGridData(
                              show: true,
                              drawVerticalLine: true,
                              drawHorizontalLine: false,
                              verticalInterval: 1),
                          axisTitleData: FlAxisTitleData(
                            bottomTitle: AxisTitle(
                              titleText: 'Win Margin',
                              showTitle: true,
                              textStyle:
                                  Theme.of(context).primaryTextTheme.body2,
                            ),
                            show: true,
                          ),
                        ),
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
                          textColor: Colors.brown[800],
                        ),
                        Indicator(
                          color: Colors.teal[400],
                          text: 'Thom',
                          isSquare: false,
                          size: 16,
                          textColor: Colors.brown[800],
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
        color: Colors.pink[200],
        width: 3,
      ),
      BarChartRodData(
        y: y2,
        color: Colors.teal[400],
        width: 3,
      ),
    ]);
  }
}
