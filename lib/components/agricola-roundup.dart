import 'package:flutter/material.dart';
import 'package:scoreboards_app/components/agricola-data.dart';
import 'package:scoreboards_app/models/agricola-background.dart';

class AgricolaRoundup extends StatelessWidget {
  final AgricolaData agricolaData;
  AgricolaRoundup({Key key, @required this.agricolaData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var numOfGames = this.agricolaData.allData.gameScores.length;
    var numOfTwoPlayerGames = this.agricolaData.twoPlayerData.length;
    var nonTwoPlayerGames = numOfGames - numOfTwoPlayerGames;
    this
        .agricolaData
        .allScoresRoundups
        .sort((a, b) => a.winningScore.compareTo(b.winningScore));
    var highestScore = this.agricolaData.allScoresRoundups.last.winningScore;
    var highestScoringPlayer = this.agricolaData.allScoresRoundups.last.winner;

    this
        .agricolaData
        .allScoresRoundups
        .sort((a, b) => a.loserScore.compareTo(b.loserScore));
    var lowestScoringPlayer =
        this.agricolaData.allScoresRoundups.first.loserName;
    var lowestScore = this.agricolaData.allScoresRoundups.first.loserScore;
    var overallAverage = (this
                .agricolaData
                .allScoresRoundups
                .map((scores) => scores.averageScore)
                .fold(0, (total, score) {
              total += score;
              return total;
            }) /
            this.agricolaData.allScoresRoundups.length)
        .toStringAsFixed(1);

    TextStyle statsText = TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        fontFamily: "AmaticSC",
        color: Colors.white,
        shadows: [Shadow(color: Colors.black, blurRadius: 35)]);

    TextStyle infoText = Theme.of(context).primaryTextTheme.body1.merge(
        TextStyle(shadows: [Shadow(color: Colors.white, blurRadius: 35)]));

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
      body: Center(
        child: Container(
          decoration: agricolaBackground,
          height: MediaQuery.of(context).size.height,
          child: Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height -
                    kBottomNavigationBarHeight),
            padding: EdgeInsets.only(
                bottom: kBottomNavigationBarHeight, left: 15, right: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Agricola',
                    style: Theme.of(context).primaryTextTheme.headline),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(132, 189, 179, 0.7),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(children: [
                    RichText(
                      text: TextSpan(
                          style: infoText,
                          text: "Number of games recorded: ",
                          children: [
                            TextSpan(style: statsText, text: "$numOfGames")
                          ]),
                    ),
                    Divider(
                      color: Colors.white,
                      indent: 15,
                      endIndent: 15,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Of those, ",
                          style: infoText,
                          children: [
                            TextSpan(
                                text: "$numOfTwoPlayerGames", style: statsText),
                            TextSpan(text: " were two player and "),
                            TextSpan(
                                text: "$nonTwoPlayerGames", style: statsText),
                            TextSpan(text: " were multiplayer games")
                          ]),
                    ),
                    Divider(
                      color: Colors.white,
                      indent: 15,
                      endIndent: 15,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "The highest score across all games was ",
                          style: infoText,
                          children: [
                            TextSpan(text: "$highestScore", style: statsText),
                            TextSpan(text: ", scored by "),
                            TextSpan(
                                text: "$highestScoringPlayer",
                                style: statsText),
                            TextSpan(text: "!")
                          ]),
                    ),
                    Divider(
                      color: Colors.white,
                      indent: 15,
                      endIndent: 15,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "And the lowest score across all games was ",
                          style: infoText,
                          children: [
                            TextSpan(text: "$lowestScore", style: statsText),
                            TextSpan(text: ", scored by "),
                            TextSpan(
                                text: "$lowestScoringPlayer", style: statsText),
                            TextSpan(text: "!")
                          ]),
                    ),
                    Divider(
                      color: Colors.white,
                      indent: 15,
                      endIndent: 15,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text:
                              "The average score across all games is a respectable ",
                          style: infoText,
                          children: [
                            TextSpan(text: "$overallAverage", style: statsText),
                          ]),
                    ),
                  ]),
                ),
                FlatButton(
                  onPressed: (() => {null}),
                  splashColor: Colors.lightBlue[100],
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Padding(
                      child: Icon(Icons.add_circle),
                      padding: EdgeInsets.only(right: 10),
                    ),
                    Text("Add A Game Score",
                        style: Theme.of(context).primaryTextTheme.subtitle),
                  ]),
                  color: Colors.lightGreen[200],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
