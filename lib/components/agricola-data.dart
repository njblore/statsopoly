import 'dart:math';
import 'package:scoreboards_app/components/agricola-raw-data.dart';

class AgricolaData {
  AllGames allData;
  var twoPlayerData;
  var multiplayerData;

  List<WinningScores> allWinners;
  List<WinningScores> twoPlayerWinners;
  List<WinningScores> multiplayerWinners;

  AgricolaData(AllGames data) {
    this.setGamedata(data);
  }

  setGamedata(AllGames allGames) {
    this.allData = allGames;
    this.twoPlayerData = allGames.gameScores
        .where((GameScore gameScore) => gameScore.playerScores.length == 2);
    this.multiplayerData = allGames.gameScores
        .where((GameScore gameScore) => gameScore.playerScores.length > 2);

    List<WinningScores> winningScores =
        this.getWinningScores(allGames.gameScores);

    this.allWinners = winningScores;
    this.twoPlayerWinners =
        winningScores.where((scores) => scores.numberOfPlayers == 2).toList();
    this.multiplayerWinners =
        winningScores.where((scores) => scores.numberOfPlayers > 2).toList();
  }

  getWinningScores(List<GameScore> games) {
    List<WinningScores> gameList = List<WinningScores>();
    for (var game in games) {
      var numberOfPlayers = game.playerScores.length;
      var allTotals = game.playerScores
          .map((scores) => scores.categoryScores
              .firstWhere((category) => category.categoryName == "total")
              .categoryPoints)
          .toList();
      var winningScore = allTotals.reduce(max);
      allTotals.remove(winningScore);
      var runnerUpScore = allTotals.reduce(max);
      var winner = game.playerScores
          .firstWhere((scores) =>
              scores.categoryScores
                  .firstWhere((category) => category.categoryName == "total")
                  .categoryPoints ==
              winningScore)
          .playerName;
      game.playerScores.removeWhere((scores) => scores.playerName == winner);

      var runnerUp = game.playerScores
          .firstWhere((scores) =>
              scores.categoryScores
                  .firstWhere((category) => category.categoryName == "total")
                  .categoryPoints ==
              runnerUpScore)
          .playerName;

      var winMargin = winningScore - runnerUpScore;

      gameList.add(new WinningScores(numberOfPlayers, runnerUp, runnerUpScore,
          winMargin, winner, winningScore));
    }
    return gameList;
  }
}
