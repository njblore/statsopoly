import 'package:flutter/material.dart';
import 'package:scoreboards_app/components/agricola-data.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:scoreboards_app/components/agricola-raw-data.dart';
import 'package:scoreboards_app/screens/agricola-win-lose-bars.dart';
import 'package:scoreboards_app/screens/win-pie.dart';
import 'package:scoreboards_app/screens/two-player-bar.dart';
import 'package:scoreboards_app/components/agricola-background.dart';

class AgricolaWins extends StatefulWidget {
  final AgricolaData agricolaData;
  AgricolaWins({Key key, @required this.agricolaData}) : super(key: key);

  @override
  _AgricolaWinsState createState() => new _AgricolaWinsState();
}

class _AgricolaWinsState extends State<AgricolaWins> {
  @override
  Widget build(BuildContext context) {
    Map<String, double> getPlayerWinsMap(List<ScoresRoundUp> roundups) {
      return roundups.fold({}, (map, roundup) {
        String winner;
        if (roundup.winMargin == 0) {
          winner = "Tie";
        } else {
          winner = roundup.winner;
        }

        if (map[winner] != null) {
          map[winner] = map[winner] + 1.0;
        } else {
          map[winner] = 1.0;
        }
        return map;
      });
    }

    Map<String, double> allPlayerWins =
        getPlayerWinsMap(widget.agricolaData.allScoresRoundups);

    Map<String, double> twoPlayerWins =
        getPlayerWinsMap(widget.agricolaData.twoPlayerRoundups);

    var multiplayerWins = getPlayerWinsMap(widget.agricolaData.allScoresRoundups
        .where((roundup) => roundup.numberOfPlayers > 2)
        .toList());

    Map<int, int> getWinMargins(String player) {
      var playerWins = widget.agricolaData.twoPlayerRoundups
          .where((roundup) => roundup.winner == player)
          .toList();
      return playerWins.fold({0: 0}, (tally, win) {
        if (tally[win.winMargin] != null) {
          tally[win.winMargin] += 1;
        } else {
          tally[win.winMargin] = 1;
        }

        return tally;
      });
    }

    var tashWinMargins = getWinMargins("Tash");
    var thomWinMargins = getWinMargins("Thom");

    var winCards = [
      WinPieCard('Overall Wins', allPlayerWins, twoPlayerWins, multiplayerWins),
      TwoPlayerWinsBar('Win Margins', tashWinMargins, thomWinMargins),
    ];

    return Scaffold(
        body: Swiper(
      itemBuilder: (BuildContext context, int index) {
        return winCards[index];
      },
      autoplay: false,
      itemCount: winCards.length,
      pagination: SwiperPagination(
          margin: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
          alignment: Alignment.bottomCenter),
      control: SwiperControl(color: Colors.white70),
      loop: false,
    ));
  }
}
