import 'package:flutter/material.dart';
import 'package:scoreboards_app/components/agricola-data.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:scoreboards_app/screens/agricola-win-lose-bars.dart';
import 'package:scoreboards_app/screens/scores-over-time.dart';

class AgricolaScores extends StatefulWidget {
  final AgricolaData agricolaData;
  AgricolaScores({Key key, @required this.agricolaData}) : super(key: key);

  @override
  _AgricolaScoresState createState() => new _AgricolaScoresState();
}

class _AgricolaScoresState extends State<AgricolaScores> {
  @override
  Widget build(BuildContext context) {
    var twoPlayerGamesWithKnownDate = widget.agricolaData.twoPlayerData
        .where((game) => game.datePlayed != null)
        .toList();
    var winningAndlosingScoresByCategories =
        widget.agricolaData.twoPlayerRoundups;

    var scoresCards = [
      ScoresOverTimeBarChart(
          'Scores Over Time', '', twoPlayerGamesWithKnownDate),
      WinLoseBars('Score Breakdowns', winningAndlosingScoresByCategories)
    ];

    return Scaffold(
      body: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return scoresCards[index];
        },
        autoplay: false,
        itemCount: scoresCards.length,
        loop: false,
        pagination: SwiperPagination(
            margin: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
            alignment: Alignment.bottomCenter),
        control: SwiperControl(color: Colors.white70),
      ),
    );
  }
}
