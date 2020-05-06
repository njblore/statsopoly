import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../components/indicator.dart';
import '../components/agricola-background.dart';

class WinPieCard extends StatefulWidget {
  WinPieCard(
      this.title, this.playerWins, this.twoPlayerWins, this.multiplayerWins);
  final Map<String, double> playerWins;
  final Map<String, double> twoPlayerWins;
  final Map<String, double> multiplayerWins;
  final String title;

  @override
  _WinPieCardState createState() => _WinPieCardState();
}

class _WinPieCardState extends State<WinPieCard> {
  int touchedIndex;
  Map<String, double> winCounts;
  String selected;

  void initState() {
    super.initState();
    setState(() {
      winCounts = widget.twoPlayerWins;
      selected = "twoPlayer";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).primaryTextTheme.title,
        ),
        centerTitle: true,
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
            padding: EdgeInsets.symmetric(vertical: kBottomNavigationBarHeight),
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                              color: selected == "twoPlayer"
                                  ? Colors.lightGreen[200]
                                  : Colors.transparent,
                              splashColor: Colors.lightBlue[200],
                              onPressed: () => setState(() {
                                    winCounts = widget.twoPlayerWins;
                                    selected = "twoPlayer";
                                  }),
                              child: Text('Two Player',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle)),
                          FlatButton(
                              color: selected == "multiplayer"
                                  ? Colors.lightGreen[200]
                                  : Colors.transparent,
                              splashColor: Colors.lightBlue[200],
                              onPressed: () => setState(() {
                                    winCounts = widget.multiplayerWins;
                                    selected = "multiplayer";
                                  }),
                              child: Text('Multiplayer',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle)),
                          FlatButton(
                              color: selected == "allGames"
                                  ? Colors.lightGreen[200]
                                  : Colors.transparent,
                              splashColor: Colors.lightBlue[200],
                              onPressed: () => setState(() {
                                    winCounts = widget.playerWins;
                                    selected = "allGames";
                                  }),
                              child: Text('All Games',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle))
                        ],
                      )
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
                        ...generateIndicators(),
                      ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Color> colorList = [
    Colors.green[600],
    Colors.pink[200],
    Colors.blueGrey[300],
    Colors.purple[100],
    Colors.orange[700],
    Colors.teal[300],
  ];

  List<PieChartSectionData> showingSections() {
    List<PieChartSectionData> data = [];
    var wins = this.winCounts.values.toList();
    for (var i = 0; i < wins.length; i++) {
      final isTouched = i == touchedIndex;
      final double radius = isTouched ? 80 : 50;

      data.add(PieChartSectionData(
          value: wins[i],
          color: colorList[i],
          title: wins[i].toStringAsFixed(0),
          radius: radius,
          titleStyle: Theme.of(context).primaryTextTheme.caption));
    }

    return data;
  }

  List<Indicator> generateIndicators() {
    var wins = this.winCounts.keys.toList();
    List<Indicator> playerIndicators = [];
    for (var i = 0; i < wins.length; i++) {
      playerIndicators.add(Indicator(
          color: colorList[i],
          text: wins[i],
          isSquare: false,
          size: 16,
          fontSize: 20,
          textColor: Colors.brown[700]));
    }
    return playerIndicators;
  }
}
