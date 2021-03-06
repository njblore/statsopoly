import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:scoreboards_app/components/agricola-raw-data.dart';
import '../components/indicator.dart';
import '../components/agricola-background.dart';

class ScoresOverTimeBarChart extends StatefulWidget {
  ScoresOverTimeBarChart(this.title, this.subtitle, this.games);

  final String title;
  final String subtitle;
  final List<GameScore> games;

  @override
  _ScoresOverTimeBarChartState createState() => _ScoresOverTimeBarChartState();
}

class _ScoresOverTimeBarChartState extends State<ScoresOverTimeBarChart> {
  int touchedIndex;

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
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.5,
                      minWidth: MediaQuery.of(context).size.width * 0.8),
                  child: Container(
                    padding: EdgeInsets.only(right: 10, top: 10, bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      color: Color.fromRGBO(255, 255, 247, 0.9),
                    ),
                    child: LineChart(LineChartData(
                      titlesData: FlTitlesData(
                          bottomTitles: SideTitles(
                            showTitles: true,
                            interval: 2,
                            getTitles: (title) {
                              var date = widget.games[title.toInt()].datePlayed;
                              var month = date.month;
                              var year = date.year;
                              return "$month/$year";
                            },
                            rotateAngle: 90,
                          ),
                          leftTitles: SideTitles(
                              margin: 1,
                              showTitles: true,
                              interval: 2,
                              getTitles: (title) => title.toStringAsFixed(0))),
                      lineBarsData: showLines(),
                    )),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Indicator(
                        color: Colors.pink[200],
                        text: 'Tash',
                        isSquare: false,
                        size: 16,
                        fontSize: 20,
                        textColor: Colors.brown[800],
                      ),
                      Indicator(
                        color: Colors.teal[300],
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
        ],
      ),
    );
  }

  List<LineChartBarData> showLines() {
    widget.games.sort((a, b) => a.datePlayed.compareTo(b.datePlayed));

    List<FlSpot> tashSpots = [];
    List<FlSpot> thomSpots = [];

    for (var game in widget.games) {
      var tashScore = game.playerScores
          .firstWhere((player) => player.playerName == "Tash")
          .categoryScores
          .firstWhere((category) => category.categoryName == "total")
          .categoryPoints
          .toDouble();
      var thomScore = game.playerScores
          .firstWhere((player) => player.playerName == "Thom")
          .categoryScores
          .firstWhere((category) => category.categoryName == "total")
          .categoryPoints
          .toDouble();

      var x = widget.games.indexOf(game).toDouble();
      tashSpots.add(new FlSpot(x, tashScore));
      thomSpots.add(new FlSpot(x, thomScore));
    }

    var tashLine = LineChartBarData(
      spots: tashSpots,
      isCurved: true,
      colors: [
        Colors.pink[300],
      ],
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );

    var thomLine = LineChartBarData(
      spots: thomSpots,
      isCurved: true,
      colors: [
        Colors.teal[400],
      ],
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );

    return [tashLine, thomLine];
  }
}
