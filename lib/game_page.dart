import 'package:flutter/material.dart';
import 'package:wildwest_flutter/widgets/card.dart';
import 'package:wildwest_flutter/widgets/player.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          _buildOther(context),
          _buildDeck(context),
          _buildYou(context),
          _buildHand(context),
        ],
      ),
    ));
  }

  Widget _buildOther(BuildContext context) {
    final players = List.generate(6, (index) => _buildPlayer(context, index));
    return IntrinsicHeight(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: players,
    ));
  }

  Widget _buildPlayer(BuildContext context, int index) {
    return PlayerWidget(name: 'player $index', width: 65, height: 100);
  }

  Widget _buildDeck(BuildContext context) {
    return Expanded(
      child: Center(
        child: _buildCard(context, -1),
      ),
    );
  }

  Widget _buildYou(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [_buildMessage(context), _buildPlayer(context, -1)],
      ),
    );
  }

  Widget _buildHand(BuildContext context) {
    return Container(
        height: 125,
        child: Stack(
          children: List.generate(
              5,
              (index) => Positioned(
                  left: (70.0 * index), child: _buildCard(context, index))),
        ));
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

  Widget _buildCard(BuildContext context, int index) {
    return CardWidget(name: 'card $index', width: 100, height: 125);
  }
}
