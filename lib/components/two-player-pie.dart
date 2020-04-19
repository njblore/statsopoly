import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/indicator.dart';
import '../models/agricola-background.dart';

class TwoPlayerPieCard extends StatefulWidget {
  TwoPlayerPieCard(this.title, this.playerOneWins, this.playerTwoWins,
      this.ties, this.subtitle);
  final double playerOneWins;
  final double playerTwoWins;
  final double ties;
  final String title;
  final String subtitle;

  @override
  _TwoPlayerPieCardState createState() => _TwoPlayerPieCardState();
}

class _TwoPlayerPieCardState extends State<TwoPlayerPieCard> {
  int touchedIndex;

  @override
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
                      Text(
                        widget.subtitle,
                        style: Theme.of(context).primaryTextTheme.subtitle,
                      ),
                    ],
                  ),
                  PieChart(
                    PieChartData(
                      sections: showingSections(),
                      borderData: FlBorderData(show: false),
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
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
                        Indicator(
                          color: Colors.grey,
                          text: 'Tie',
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

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double radius = isTouched ? 80 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            value: widget.playerOneWins,
            color: Colors.pink[300],
            title: widget.playerOneWins.toString(),
            radius: radius,
            titleStyle: Theme.of(context).primaryTextTheme.caption,
          );
        case 1:
          return PieChartSectionData(
            value: widget.playerTwoWins,
            color: Colors.lightGreen[700],
            title: widget.playerTwoWins.toString(),
            radius: radius,
            titleStyle: Theme.of(context).primaryTextTheme.caption,
          );
        case 2:
          return PieChartSectionData(
            value: widget.ties,
            color: Colors.grey,
            title: widget.ties.toString(),
            titleStyle: Theme.of(context).primaryTextTheme.caption,
            radius: radius,
          );
        default:
          return null;
      }
    });
  }
}
