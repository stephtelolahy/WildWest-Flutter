import 'package:flutter/material.dart';
import 'package:wildwest_flutter/misc/size_utils.dart';
import 'package:wildwest_flutter/pages/game/widgets/card.dart';

class HandWidget extends StatelessWidget {
  final List<String> cards;

  HandWidget({required this.cards});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: CardWidget.CARD_HEIGHT,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          cards.length,
          (index) => CardWidget(
            name: cards[index],
            maxWidth: SizeUtils.maxItemWidthInARow(context, cards.length),
            draggable: true,
          ),
        ),
      ),
    );
  }
}
