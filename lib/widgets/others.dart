import 'package:flutter/material.dart';
import 'package:wildwest_flutter/misc/size_utils.dart';
import 'package:wildwest_flutter/widgets/player.dart';

class OthersWidget extends StatelessWidget {
  static const double PLAYER_WIDTH = 80;
  static const double PLAYER_HEIGHT = 100;

  @override
  Widget build(BuildContext context) {
    final playersCount = 5;

    final players = List.generate(
      playersCount,
      (index) => PlayerWidget(
        name: 'player $index',
        width: SizeUtils.itemWidthInARow(context, playersCount, PLAYER_WIDTH),
        height: PLAYER_HEIGHT,
      ),
    );
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: players,
      ),
    );
  }
}
