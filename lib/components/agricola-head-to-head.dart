import 'package:flutter/material.dart';
import 'package:scoreboards_app/components/agricola-data.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:scoreboards_app/components/two-player-pie.dart';

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

    var pieCards = [
      TwoPlayerPieCard(
          'Head to Head: Overall', allTashWins, allThomWins, allTies),
      TwoPlayerPieCard(
          'Average Win Margins',
          num.parse(tashAvgWinMargin.toStringAsFixed(1)),
          num.parse(thomAvgWinMargin.toStringAsFixed(1)),
          allTies)
    ];

    return Scaffold(
      body: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return pieCards[index];
        },
        autoplay: false,
        itemCount: 2,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
    );
  }
}
