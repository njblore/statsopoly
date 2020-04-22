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
  int touchedIndex;
  Widget build(BuildContext context) {
    var thomWinAvg =
        widget.thomWinMargins.keys.fold(0, (total, margin) => total += margin) /
            widget.thomWinMargins.keys.length;
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
                                  width: 30,
                                  height: 30,
                                  child: Center(
                                    child: Text(tashWinAvg.toStringAsFixed(0),
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.pink[300],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  )),
                              Text(
                                "<- Average ->",
                                style:
                                    Theme.of(context).primaryTextTheme.subtitle,
                              ),
                              Container(
                                  width: 30,
                                  height: 30,
                                  child: Center(
                                    child: Text(thomWinAvg.toStringAsFixed(0),
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.teal[400],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  )),
                            ]),
                      ),
                    ],
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.5,
                        minWidth: MediaQuery.of(context).size.width * 0.8),
                    child: Container(
                      padding: EdgeInsets.only(right: 10, top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        color: Colors.white38,
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
                                  getTitles: (title) =>
                                      title.toStringAsFixed(0),
                                ),
                                leftTitles: SideTitles(
                                    textStyle: Theme.of(context)
                                        .primaryTextTheme
                                        .body2,
                                    margin: 0.5,
                                    getTitles: (title) =>
                                        title.toStringAsFixed(0),
                                    showTitles: true)),
                            backgroundColor: Colors.transparent,
                            borderData: FlBorderData(show: false),
                            barGroups: makeBarGroups(),
                            barTouchData: BarTouchData(
                              touchTooltipData: BarTouchTooltipData(
                                  tooltipBgColor: Colors.blueGrey,
                                  getTooltipItem:
                                      (group, groupIndex, rod, rodIndex) {
                                    String playerName;
                                    switch (rodIndex) {
                                      case 0:
                                        playerName = "Tash";
                                        break;
                                      case 1:
                                        playerName = "Thom";
                                        break;
                                    }
                                    String timeCounts;
                                    switch (rod.y.toInt()) {
                                      case 1:
                                        timeCounts = " time ";
                                        break;
                                      default:
                                        timeCounts = " times ";
                                        break;
                                    }
                                    return BarTooltipItem(
                                        playerName +
                                            " won by " +
                                            group.x.toString() +
                                            " points" +
                                            '\n' +
                                            (rod.y).toStringAsFixed(0) +
                                            timeCounts,
                                        TextStyle(color: Colors.yellow));
                                  }),
                              touchCallback: (barTouchResponse) {
                                setState(() {
                                  if (barTouchResponse.spot != null &&
                                      barTouchResponse.touchInput
                                          is! FlPanEnd &&
                                      barTouchResponse.touchInput
                                          is! FlLongPressEnd) {
                                    touchedIndex = barTouchResponse
                                        .spot.touchedBarGroupIndex;
                                  } else {
                                    touchedIndex = -1;
                                  }
                                });
                              },
                            )),
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
                          fontSize: 20,
                          textColor: Colors.brown[800],
                        ),
                        Indicator(
                          color: Colors.teal[400],
                          text: 'Thom',
                          isSquare: false,
                          size: 16,
                          fontSize: 20,
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

  BarChartGroupData makeGroupData(
    int x,
    double y1,
    double y2,
    bool isTouched,
  ) {
    return BarChartGroupData(barsSpace: 1, x: x, barRods: [
      BarChartRodData(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6), topRight: Radius.circular(6)),
        y: y1,
        color: isTouched ? Colors.yellow : Colors.pink[300],
        width: 4,
        backDrawRodData: BackgroundBarChartRodData(
          show: true,
          y: 6,
          color: Color.fromRGBO(194, 93, 138, 0.2),
        ),
      ),
      BarChartRodData(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6), topRight: Radius.circular(6)),
        y: y2,
        color: isTouched ? Colors.yellow : Colors.teal[400],
        width: 4,
        backDrawRodData: BackgroundBarChartRodData(
          show: true,
          y: 6,
          color: Color.fromRGBO(72, 189, 169, 0.2),
        ),
      ),
    ]);
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

      var isTouched = i == touchedIndex;

      barGroups.add(makeGroupData(i, tashFrequency, thomFrequency, isTouched));
    }

    return barGroups;
  }
}
