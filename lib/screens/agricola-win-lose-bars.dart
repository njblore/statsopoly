import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:scoreboards_app/components/agricola-raw-data.dart';
import 'package:scoreboards_app/components/agricola-background.dart';
import 'package:scoreboards_app/components/indicator.dart';

class WinLoseBars extends StatefulWidget {
  WinLoseBars(this.title, this.allScoresRoundups);

  final String title;
  final List<ScoresRoundUp> allScoresRoundups;

  @override
  _WinLoseBarsState createState() => _WinLoseBarsState();
}

class _WinLoseBarsState extends State<WinLoseBars> {
  bool winningOn;
  int touchedIndex;

  void initState() {
    super.initState();
    setState(() {
      winningOn = true;
    });
  }

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
            padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
            height: MediaQuery.of(context).size.height,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
                              onPressed: () => setState(() => winningOn = true),
                              color: winningOn
                                  ? Colors.lightGreen[200]
                                  : Colors.transparent,
                              splashColor: Colors.lightBlue[200],
                              child: Text("Winning Scores",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle)),
                          FlatButton(
                            onPressed: () => setState(() => winningOn = false),
                            color: !winningOn
                                ? Colors.lightGreen[200]
                                : Colors.transparent,
                            splashColor: Colors.lightBlue[200],
                            child: Text("Losing Scores",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle),
                          )
                        ],
                      )
                    ],
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.5,
                        minWidth: MediaQuery.of(context).size.width * 0.8),
                    child: Container(
                      padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        color: Colors.white54,
                      ),
                      child: BarChart(
                        BarChartData(
                            backgroundColor: Colors.transparent,
                            borderData: FlBorderData(show: false),
                            barGroups: makeBarGroups(this.winningOn),
                            minY: 0,
                            titlesData: FlTitlesData(
                              show: true,
                              leftTitles: SideTitles(
                                  interval: 4,
                                  showTitles: true,
                                  getTitles: (title) =>
                                      title.toStringAsFixed(0)),
                              bottomTitles:
                                  SideTitles(showTitles: false, margin: 5),
                            ),
                            gridData: FlGridData(
                              drawHorizontalLine: true,
                              horizontalInterval: 4,
                            ),
                            barTouchData: BarTouchData(
                              touchTooltipData: BarTouchTooltipData(
                                  getTooltipItem:
                                      (group, groupIndex, rod, rodIndex) {
                                var game = widget.allScoresRoundups[groupIndex];
                                var player =
                                    winningOn ? game.winner : game.loserName;
                                var verb = winningOn ? ' won' : ' lost';
                                var scores = winningOn
                                    ? game.winnerScores
                                    : game.loserScores;
                                return BarTooltipItem(
                                    player +
                                        verb +
                                        " with " +
                                        rod.y.toStringAsFixed(0) +
                                        " points",
                                    TextStyle(color: Colors.blueGrey));
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[...generateIndicators()],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> makeBarGroups(bool winning) {
    List<BarChartGroupData> groupData = [];

    widget.allScoresRoundups
        .sort((a, b) => a.winningScore.compareTo(b.winningScore));

    widget.allScoresRoundups.asMap().forEach((i, roundup) {
      var score = winning ? roundup.winningScore : roundup.loserScore;
      var catScores = winning ? roundup.winnerScores : roundup.loserScores;
      groupData.add(makeGroupData(
        i,
        score.toDouble(),
        makeCategoryStack(catScores),
      ));
    });

    return groupData;
  }

  BarChartGroupData makeGroupData(
    int x,
    double totalScore,
    List<BarChartRodStackItem> categoryStack,
  ) {
    return BarChartGroupData(barsSpace: 1, x: x, barRods: [
      BarChartRodData(
          rodStackItem: categoryStack,
          y: totalScore,
          color: Colors.transparent,
          width: 3,
          borderRadius: BorderRadius.zero),
    ]);
  }

  Map<String, Color> categoryColors = {
    "fields": Colors.green,
    "pastures": Colors.brown,
    "grain": Colors.yellow,
    "vegetables": Colors.orange,
    "sheep": Colors.white,
    "wild boar": Colors.black,
    "cattle": Colors.brown[700],
    "fenced stables": Colors.purple[400],
    "clay rooms": Colors.deepOrange[400],
    "stone rooms": Colors.lightBlue[100],
    "family members": Colors.teal[400],
    "points for cards": Colors.pink[200],
    "bonus points": Colors.lime,
    "unused spaces": Colors.red,
  };

  List<BarChartRodStackItem> makeCategoryStack(
      List<CategoryScore> playerScores) {
    double positivePosish = 0.0;
    double negativePosish = 0.0;
    List<BarChartRodStackItem> catRods = [];

    for (var score
        in playerScores.where((score) => score.categoryName != "total")) {
      var startPoint;
      var catRod;

      if (score.categoryPoints >= 0) {
        startPoint = positivePosish;
        catRod = BarChartRodStackItem(
            startPoint,
            startPoint + score.categoryPoints.toDouble(),
            categoryColors[score.categoryName]);
        positivePosish = score.categoryPoints + startPoint;
      } else {
        startPoint = negativePosish;
        catRod = BarChartRodStackItem(startPoint,
            startPoint + score.categoryPoints.toDouble(), Colors.white);
        negativePosish = negativePosish + score.categoryPoints;
      }

      catRods.add(catRod);
    }
    return catRods;
  }

  generateIndicators() {
    var categoryIndicators = [];
    categoryColors.forEach((i, cat) {
      categoryIndicators.add(FittedBox(
          fit: BoxFit.contain,
          child: Indicator(
              color: cat,
              text: categoryColors.keys
                  .firstWhere((k) => categoryColors[k] == cat,
                      orElse: () => null)
                  .toString(),
              isSquare: false,
              size: 8,
              fontSize: 16,
              textColor: cat)));
    });

    return categoryIndicators;
  }
}
