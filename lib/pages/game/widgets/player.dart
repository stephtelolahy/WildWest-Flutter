import 'dart:math';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

class PlayerWidget extends StatelessWidget {
  static const double PLAYER_WIDTH = 80;
  static const double PLAYER_HEIGHT = 70;

  final GPlayer player;
  final Color? highlight;
  final double maxWidth;
  final bool showInPlayUp;

  const PlayerWidget({
    Key? key,
    required this.player,
    this.highlight,
    this.maxWidth = PLAYER_WIDTH,
    this.showInPlayUp = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> childWidgets = [];

    childWidgets.add(Container(
      color: highlight,
      height: PLAYER_HEIGHT,
      child: Card(
        child: Column(
          children: [
            Text(player.roleText()),
            Text(player.name, maxLines: 1),
            Text(player.healthText()),
          ],
        ),
      ),
    ));

    player.inPlay.forEach((e) {
      final widget = Text('[${e.name}]',
          maxLines: 1,
          style: TextStyle(
            backgroundColor: Colors.blue,
          ));

      if (showInPlayUp) {
        childWidgets.insert(0, widget);
      } else {
        childWidgets.add(widget);
      }
    });

    return Container(
      width: min(PLAYER_WIDTH, maxWidth),
      child: Column(children: childWidgets),
    );
  }
}

extension DisplayText on GPlayer {
  String roleText() {
    return (role == Role.sheriff || health == 0) ? EnumToString.convertToString(role) : '?';
  }

  String healthText() {
    return (health > 0) ? 'x$health  []${hand.length}' : '-';
  }
}
