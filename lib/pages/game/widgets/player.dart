import 'dart:math';

import 'package:flutter/material.dart';

class PlayerWidget extends StatelessWidget {
  static const double PLAYER_WIDTH = 80;
  static const double PLAYER_HEIGHT = 100;

  final String name;
  final double maxWidth;

  const PlayerWidget({
    Key? key,
    required this.name,
    this.maxWidth = PLAYER_WIDTH,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: min(PLAYER_WIDTH, maxWidth),
      height: PLAYER_HEIGHT,
      child: Card(
        child: Center(
          child: Text(name, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
