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
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                Text('Agricola',
                    style: Theme.of(context).primaryTextTheme.headline),
                Container(
                  child:
                      Text('A summary of Games', textAlign: TextAlign.justify),
                ),
                Text('Number of games recorded: $numOfGames'),
                Text(
                    'Of those, $numOfTwoPlayerGames were two player games, and $nonTwoPlayerGames were multiplayer games'),
                Text(
                    'The highest score across all games was $highestScore, scored by $highestScoringPlayer!'),
                Text(
                    'And the lowest score across all games was $lowestScore, scored by $lowestScoringPlayer :('),
                Text(
                    'The average score across all games is a respectable $overallAverage')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
