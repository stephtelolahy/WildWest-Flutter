import 'package:flutter/material.dart';
import 'package:wildwest_flutter/widgets/discard.dart';
import 'package:wildwest_flutter/widgets/hand.dart';
import 'package:wildwest_flutter/widgets/player.dart';

class GamePage extends StatelessWidget {
  static const double PLAYER_WIDTH = 65;
  static const double PLAYER_HEIGHT = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          _buildOther(context),
          DiscardWidget(),
          _buildYou(context),
          HandWidget(),
        ],
      ),
    ));
  }

  Widget _buildOther(BuildContext context) {
    final players = List.generate(6, (index) => _buildPlayer(context, index));
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: players,
    ));
  }

  Widget _buildPlayer(BuildContext context, int index) {
    return PlayerWidget(
        name: 'player $index', width: PLAYER_WIDTH, height: PLAYER_HEIGHT);
  }

  Widget _buildYou(BuildContext context) {
    return Container(
      child: Row(
        children: [
          _buildMessage(context),
          _buildPlayer(context, -1),
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
