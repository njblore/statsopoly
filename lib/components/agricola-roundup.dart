import 'package:flutter/material.dart';
import 'package:scoreboards_app/components/agricola-data.dart';

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
        .allWinners
        .sort((a, b) => a.winningScore.compareTo(b.winningScore));
    var highestScore = this.agricolaData.allWinners.last.winningScore;
    var highestScoringPlayer = this.agricolaData.allWinners.last.winner;

    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Agricola!'),
            Text('Number of games recorded: $numOfGames'),
            Text(
                'Of those, $numOfTwoPlayerGames were two player games, and $nonTwoPlayerGames were multiplayer games'),
            Text(
                'The highest score across all games was $highestScore, scored by $highestScoringPlayer'),
          ],
        ),
      ),
    );
  }
}
