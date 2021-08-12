import 'package:flutter/material.dart';
import 'package:wildwest_flutter/misc/size_utils.dart';
import 'package:wildwest_flutter/pages/game/widgets/player.dart';

class OthersWidget extends StatelessWidget {
  final List<String> players;

  OthersWidget(this.players);

  @override
  Widget build(BuildContext context) {
    final maxWidth = SizeUtils.maxItemWidthInARow(context, players.length);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: players
            .map((e) => PlayerWidget(name: e, maxWidth: maxWidth))
            .toList(),
      ),
    );
  }
}
