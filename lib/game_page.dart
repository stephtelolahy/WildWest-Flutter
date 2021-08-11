import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wildwest_flutter/widgets/card.dart';
import 'package:wildwest_flutter/widgets/player.dart';

class GamePage extends StatelessWidget {
  static const double CARD_WIDTH = 96;
  static const double CARD_HEIGHT = 144;
  static const double CARD_SPACING = 2;

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
    return Container(
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
        child: CardWidget(
          name: 'discard',
          size: Size(CARD_WIDTH, CARD_HEIGHT),
          sizeWhenDragging: Size(CARD_WIDTH, CARD_HEIGHT),
        ),
      ),
    );
  }

  Widget _buildYou(BuildContext context) {
    return Container(
      child: Row(
        children: [_buildMessage(context), _buildPlayer(context, -1)],
      ),
    );
  }

  Widget _buildHand(BuildContext context) {
    final itemsCount = 2;
    final screenW = MediaQuery.of(context).size.width;
    final double cardWidth = (screenW - itemsCount * CARD_SPACING) / itemsCount;
    final double width = min(cardWidth, CARD_WIDTH);

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          itemsCount,
          (index) => CardWidget(
            name: 'card $index',
            size: Size(width, CARD_HEIGHT),
            sizeWhenDragging: Size(CARD_WIDTH, CARD_HEIGHT),
          ),
        ),
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
