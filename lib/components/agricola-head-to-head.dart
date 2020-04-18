import 'package:flutter/material.dart';
import 'package:scoreboards_app/components/agricola-data.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:scoreboards_app/components/pie-chart-card.dart';

class HeadToHead extends StatelessWidget {
  final AgricolaData agricolaData;
  HeadToHead({Key key, @required this.agricolaData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var allTashWins = agricolaData.twoPlayerRoundups
        .where((scores) => scores.winner == 'Tash')
        .where((scores) => scores.winMargin != 0)
        .length
        .toDouble();
    var allThomWins = agricolaData.twoPlayerRoundups
        .where((scores) => scores.winner == 'Thom')
        .where((scores) => scores.winMargin != 0)
        .length
        .toDouble();
    var allTies = agricolaData.twoPlayerRoundups
        .where((scores) => scores.winMargin == 0)
        .length
        .toDouble();

    return PieChartCard(
        'Head to Head: Overall', allTashWins, allThomWins, allTies);
  }
}
