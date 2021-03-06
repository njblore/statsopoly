import 'package:scoreboards_app/components/agricola-raw-data.dart';

class AgricolaData {
  AllGames allData;
  List<GameScore> twoPlayerData;
  List<GameScore> multiplayerData;

  List<ScoresRoundUp> allScoresRoundups;
  List<ScoresRoundUp> twoPlayerRoundups;
  List<ScoresRoundUp> multiplayerRoundups;
  var allLosers;

  AgricolaData(AllGames data) {
    this.setGamedata(data);
  }

  setGamedata(AllGames allGames) {
    this.allData = allGames;
    this.twoPlayerData = allGames.gameScores
        .where((GameScore gameScore) => gameScore.playerScores.length == 2)
        .toList();
    this.multiplayerData = allGames.gameScores
        .where((GameScore gameScore) => gameScore.playerScores.length > 2)
        .toList();
    List<ScoresRoundUp> scoreRoundups =
        this.getGameScoreRoundups(allGames.gameScores);

    this.allScoresRoundups = scoreRoundups;
    this.twoPlayerRoundups =
        scoreRoundups.where((scores) => scores.numberOfPlayers == 2).toList();
    this.multiplayerRoundups =
        scoreRoundups.where((scores) => scores.numberOfPlayers > 2).toList();
  }

  getGameScoreRoundups(List<GameScore> games) {
    List<ScoresRoundUp> gameList = List<ScoresRoundUp>();
    for (var game in games) {
      var numberOfPlayers = game.playerScores.length;
      var averageScore =
          num.parse(getAverageGameScore(game.playerScores).toStringAsFixed(1));

      // SORT BY TOTAL SCORES IN EACH GAME
      game.playerScores.sort((a, b) => a.categoryScores
          .firstWhere((category) => category.categoryName == "total")
          .categoryPoints
          .compareTo(b.categoryScores
              .firstWhere((category) => category.categoryName == "total")
              .categoryPoints));

      // HIGHEST SCORE IS AT THE END
      var winningScore = game.playerScores.last.categoryScores
          .firstWhere((category) => category.categoryName == "total")
          .categoryPoints;
      var winner = game.playerScores.last.playerName;
      var winnerScores = game.playerScores
          .firstWhere((scores) => scores.playerName == winner)
          .categoryScores;

      var runnerup = game.playerScores[game.playerScores.length - 2];

      var runnerUpScore = runnerup.categoryScores
          .firstWhere((category) => category.categoryName == "total")
          .categoryPoints;

      var runnerUp = runnerup.playerName;
      var winMargin = winningScore - runnerUpScore;

      // LOWEST SCORE AT THE START  OF SORTED LIST
      var lowestScore = game.playerScores.first.categoryScores
          .firstWhere((category) => category.categoryName == "total")
          .categoryPoints;

      var lowestScoringPlayer = game.playerScores.first.playerName;
      var losingScores = game.playerScores
          .firstWhere((scores) => scores.playerName == lowestScoringPlayer)
          .categoryScores;

      gameList.add(new ScoresRoundUp(
          numberOfPlayers,
          runnerUp,
          runnerUpScore,
          winMargin,
          winner,
          winningScore,
          lowestScore,
          lowestScoringPlayer,
          averageScore,
          winnerScores,
          losingScores));
    }
    return gameList;
  }

  getAverageGameScore(List<PlayerScore> playerScores) {
    var totals = playerScores.map((score) => score.categoryScores
        .firstWhere((category) => category.categoryName == "total")
        .categoryPoints);

    var grandTotal = totals.fold(0, (total, score) {
      total += score;
      return total;
    });

    return grandTotal / playerScores.length;
  }
}
