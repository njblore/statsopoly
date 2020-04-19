import 'package:flutter/material.dart';
import 'package:scoreboards_app/components/agricola-data.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:scoreboards_app/components/scores-over-time.dart';
import 'package:scoreboards_app/components/two-player-pie.dart';
import 'package:scoreboards_app/components/two-player-scatter.dart';

class HeadToHead extends StatefulWidget {
  final AgricolaData agricolaData;
  HeadToHead({Key key, @required this.agricolaData}) : super(key: key);

  @override
  _HeadToHeadState createState() => new _HeadToHeadState();
}

class _HeadToHeadState extends State<HeadToHead> {
  @override
  Widget build(BuildContext context) {
    var thomWins = widget.agricolaData.twoPlayerRoundups
        .where((scores) => scores.winner == 'Thom')
        .where((scores) => scores.winMargin != 0);
    var tashWins = widget.agricolaData.twoPlayerRoundups
        .where((scores) => scores.winner == 'Tash')
        .where((scores) => scores.winMargin != 0);

    var allTashWins = tashWins.length.toDouble();
    var allThomWins = thomWins.length.toDouble();

    var allTies = widget.agricolaData.twoPlayerRoundups
        .where((scores) => scores.winMargin == 0)
        .length
        .toDouble();

    var thomAvgWinMargin = thomWins.fold(0, (total, win) {
          total += win.winMargin;
          return total;
        }) /
        allThomWins;
    var tashAvgWinMargin = tashWins.fold(0, (total, win) {
          total += win.winMargin;
          return total;
        }) /
        allTashWins;

    Map<int, int> getWinMargins(playerWins) {
      return playerWins.fold({0: 0}, (tally, win) {
        if (tally[win.winMargin] != null) {
          tally[win.winMargin] += 1;
        } else {
          tally[win.winMargin] = 1;
        }

        return tally;
      });
    }

    var tashWinMargins = getWinMargins(tashWins);
    var thomWinMargins = getWinMargins(thomWins);

    var twoPlayerGamesWithKnownDate = widget.agricolaData.twoPlayerData
        .where((game) => game.datePlayed != null)
        .toList();

    var pieCards = [
      TwoPlayerPieCard(
          'Head to Head', allTashWins, allThomWins, allTies, 'Overall Wins'),
      TwoPlayerScatter('Win Margins', tashWinMargins, thomWinMargins),
      ScoresOverTimeBarChart(
          'Scores Over Time', '', twoPlayerGamesWithKnownDate)
    ];

    return Scaffold(
      body: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return pieCards[index];
        },
        autoplay: false,
        itemCount: pieCards.length,
        pagination: SwiperPagination(
            margin: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
            alignment: Alignment.bottomCenter),
        control: SwiperControl(color: Colors.white70),
      ),
    );
  }
}
