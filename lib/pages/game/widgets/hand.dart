import 'package:flutter/material.dart';
import 'package:wildwest_flutter/misc/size_utils.dart';
import 'package:wildwest_flutter/pages/game/widgets/card.dart';

class HandWidget extends StatelessWidget {
  static const double CARD_WIDTH = 96;
  static const double CARD_HEIGHT = 144;

  final List<String> cards;

  HandWidget({required this.cards});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: CARD_HEIGHT,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          cards.length,
          (index) => CardWidget(
            name: cards[index],
            size: Size(
                SizeUtils.itemWidthInARow(context, cards.length, CARD_WIDTH),
                CARD_HEIGHT),
            sizeWhenDragging: Size(CARD_WIDTH, CARD_HEIGHT),
          ),
        ),
      ),
    );
  }
}
