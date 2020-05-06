import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scoreboards_app/components/agricola-data.dart';
import 'package:scoreboards_app/components/agricola-background.dart';

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
        color: Colors.orange,
        shadows: [
          Shadow(color: Colors.black, blurRadius: 2, offset: Offset(0.5, 0.5))
        ]);

    TextStyle infoText2 = Theme.of(context).primaryTextTheme.body1.merge(
          TextStyle(color: Colors.white, shadows: [
            Shadow(color: Colors.black, blurRadius: 3, offset: Offset(0.5, 0.5))
          ]),
        );

    TextStyle infoText1 = Theme.of(context).primaryTextTheme.body1.merge(
          TextStyle(color: Colors.black, shadows: [
            Shadow(color: Colors.white, blurRadius: 3, offset: Offset(0.5, 0.5))
          ]),
        );

    Divider factDivider = Divider(
      color: Colors.brown[800].withOpacity(0.8),
      thickness: 0.8,
      indent: 15,
      endIndent: 15,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
        title: Text('Agricola',
            style: Theme.of(context).primaryTextTheme.headline),
      ),
      body: Center(
        child: Container(
          decoration: agricolaBackground,
          height: MediaQuery.of(context).size.height,
          child: Container(
            padding: EdgeInsets.only(
                bottom: kBottomNavigationBarHeight + 10,
                left: 20,
                right: 20,
                top: 100),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
              child: Container(
                padding: EdgeInsets.all(10),
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //       end: Alignment.bottomCenter,
                //       begin: Alignment.topCenter,
                //       colors: [
                //         Color.fromRGBO(250, 255, 255, 0.3),
                //         Color.fromRGBO(250, 255, 255, 0.5)
                //       ]),
                // ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                            style: infoText1,
                            text: "Number of games recorded: ",
                            children: [
                              TextSpan(style: statsText, text: "$numOfGames")
                            ]),
                      ),
                      factDivider,
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Of those, ",
                            style: infoText1,
                            children: [
                              TextSpan(
                                  text: "$numOfTwoPlayerGames",
                                  style: statsText),
                              TextSpan(text: " were two player and "),
                              TextSpan(
                                  text: "$nonTwoPlayerGames", style: statsText),
                              TextSpan(text: " were multiplayer games")
                            ]),
                      ),
                      factDivider,
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "The highest score across all games was ",
                            style: infoText2,
                            children: [
                              TextSpan(text: "$highestScore", style: statsText),
                              TextSpan(text: ", scored by "),
                              TextSpan(
                                  text: "$highestScoringPlayer",
                                  style: statsText),
                              TextSpan(text: "!")
                            ]),
                      ),
                      factDivider,
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "And the lowest score across all games was ",
                            style: infoText2,
                            children: [
                              TextSpan(text: "$lowestScore", style: statsText),
                              TextSpan(text: ", scored by "),
                              TextSpan(
                                  text: "$lowestScoringPlayer",
                                  style: statsText),
                              TextSpan(text: "!")
                            ]),
                      ),
                      factDivider,
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text:
                                "The average score across all games is a respectable ",
                            style: infoText2,
                            children: [
                              TextSpan(
                                  text: "$overallAverage", style: statsText),
                            ]),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
