import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:scoreboards_app/models/agricola-background.dart';
import 'package:scoreboards_app/models/indicator.dart';

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
      ...makeScatter(widget.tashWinMargins, Colors.pink[300]),
      ...makeScatter(widget.thomWinMargins, Colors.green[700])
    ];

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
                        minHeight: MediaQuery.of(context).size.height * 0.6,
                        minWidth: MediaQuery.of(context).size.width * 0.8),
                    child: ScatterChart(
                      ScatterChartData(
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
                        scatterSpots: scatterSpots,
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

  List<ScatterSpot> makeScatter(winMargin, Color color) {
    return winMargin.entries
        .map<ScatterSpot>((marginTally) => new ScatterSpot(
            marginTally.key.toDouble(), marginTally.value.toDouble(),
            color: color))
        .toList();
  }
}
