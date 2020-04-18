import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

Future<String> _loadAGameAsset() async {
  return await rootBundle.loadString('assets/scores.json');
}

Future loadGame() async {
  String jsonString = await _loadAGameAsset();
  final jsonResponse = json.decode(jsonString);
  AllGames gameScores = new AllGames.fromJson(jsonResponse);
  return gameScores;
}

class CategoryScore {
  String categoryName;
  int categoryPoints;
  CategoryScore({this.categoryName, this.categoryPoints});

  @override
  toString() {
    return "'$categoryName' : '$categoryPoints'";
  }

  factory CategoryScore.fromJson(Map<String, dynamic> parsedJson) {
    return CategoryScore(
        categoryName: parsedJson['category'],
        categoryPoints: parsedJson['value']);
  }
}

class PlayerScore {
  String playerName;
  List<CategoryScore> categoryScores;
  PlayerScore({this.playerName, this.categoryScores});

  @override
  toString() {
    return "player : '$playerName', scores: '$categoryScores'";
  }

  factory PlayerScore.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['scores'] as List;
    List<CategoryScore> categoryScores =
        list.map((category) => CategoryScore.fromJson(category)).toList();
    return PlayerScore(
        playerName: parsedJson['name'], categoryScores: categoryScores);
  }
}

class GameScore {
  List<PlayerScore> playerScores;
  String datePlayed;
  String locationPlayed;
  GameScore({this.playerScores, this.locationPlayed, this.datePlayed});

  @override
  toString() {
    return "playerscores: '$playerScores', date: '$datePlayed', location: '$locationPlayed' ";
  }

  factory GameScore.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['players'] as List;
    List<PlayerScore> playerScores =
        list.map((player) => PlayerScore.fromJson(player)).toList();
    return GameScore(
        playerScores: playerScores,
        datePlayed: parsedJson['date'],
        locationPlayed: parsedJson['location']);
  }
}

class AllGames {
  List<GameScore> gameScores;
  AllGames({this.gameScores});

  @override
  toString() {
    return "games: '$gameScores'";
  }

  factory AllGames.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['games'] as List;
    List<GameScore> gameScores =
        list.map((game) => GameScore.fromJson(game)).toList();
    return AllGames(gameScores: gameScores);
  }
}

class ScoresRoundUp {
  String winner;
  int winningScore;
  int numberOfPlayers;
  String runnerUp;
  int runnerUpScore;
  int winMargin;
  String loserName;
  int loserScore;
  double averageScore;
  @override
  toString() {
    return "winner: '$winner', winningScore: '$winningScore', numberOfPlayers: '$numberOfPlayers', runnerUp: '$runnerUp', runnerUpScore: '$runnerUpScore', winMargin: '$winMargin', averageScore: $averageScore";
  }

  ScoresRoundUp(
      this.numberOfPlayers,
      this.runnerUp,
      this.runnerUpScore,
      this.winMargin,
      this.winner,
      this.winningScore,
      this.loserScore,
      this.loserName,
      this.averageScore);
}
