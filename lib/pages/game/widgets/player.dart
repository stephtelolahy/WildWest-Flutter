import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

class PlayerWidget extends StatelessWidget {
  static const double PLAYER_WIDTH = 80;
  static const double PLAYER_HEIGHT = 100;

  final GPlayer player;
  final double maxWidth;

  const PlayerWidget({
    Key? key,
    required this.player,
    this.maxWidth = PLAYER_WIDTH,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: min(PLAYER_WIDTH, maxWidth),
      height: PLAYER_HEIGHT,
      child: Card(
        child: Center(
          child: Text('${player.name.substring(0, 8)}\nx${player.health}\n[]${player.hand.length}',
              textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
