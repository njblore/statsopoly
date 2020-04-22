import 'dart:async' show Future;
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> _fetchGames() {
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'secret-key':
        '\$2b\$10\$tVk/rIX8TJ15Zm5Oghjz1.0zwMVyQyzIUggpp/cngra1xISpd9N/q'
  };
  return http.get("https://api.jsonbin.io/b/5ea01b9b2940c704e1dc9684",
      headers: requestHeaders);
}

Future loadGames() async {
  http.Response res = await _fetchGames();
  final jsonResponse = json.decode(res.body);
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
    return "{player : '$playerName'}";
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
  DateTime datePlayed;
  String locationPlayed;
  GameScore({this.playerScores, this.locationPlayed, this.datePlayed});

  @override
  toString() {
    return "{playerscores: ['$playerScores'], date: '$datePlayed', location: '$locationPlayed' }";
  }

  factory GameScore.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['players'] as List;
    List<PlayerScore> playerScores =
        list.map((player) => PlayerScore.fromJson(player)).toList();

    DateTime datePlayed;
    if (parsedJson['date'] == "unkown" || parsedJson['date'].length != 10) {
      datePlayed = null;
    } else {
      var day = parsedJson['date'].substring(0, 2);
      var month = parsedJson['date'].substring(3, 5);
      var year = parsedJson['date'].substring(
        6,
      );
      String formattedDate = "$year$month$day";
      datePlayed = DateTime.parse(formattedDate);
    }

    return GameScore(
        playerScores: playerScores,
        datePlayed: datePlayed,
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
    var list = parsedJson['agricolaGames'] as List;
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
  List<CategoryScore> winnerScores;
  List<CategoryScore> loserScores;
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
      this.averageScore,
      this.winnerScores,
      this.loserScores);
}
