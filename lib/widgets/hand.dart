import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wildwest_flutter/widgets/card.dart';

class HandWidget extends StatelessWidget {
  static const double CARD_WIDTH = 96;
  static const double CARD_HEIGHT = 144;
  static const double CARD_SPACING = 2;

  @override
  Widget build(BuildContext context) {
    final itemsCount = 3;
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
}
