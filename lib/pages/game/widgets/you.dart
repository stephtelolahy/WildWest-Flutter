import 'package:flutter/material.dart';
import 'package:wildwest_flutter/pages/game/widgets/player.dart';

class YouWidget extends StatelessWidget {
  static const double PLAYER_WIDTH = 65;
  static const double PLAYER_HEIGHT = 100;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          _buildMessage(context),
          PlayerWidget(name: 'you', width: PLAYER_WIDTH, height: PLAYER_HEIGHT)
        ],
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    final message =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque at sodales augue. Maecenas consequat odio in enim fringilla, id dapibus neque commodo.";
    return Expanded(
        child: Padding(
      padding: EdgeInsets.all(8),
      child: Text(message),
    ));
  }
}
