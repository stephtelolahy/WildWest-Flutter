import 'package:flutter/material.dart';
import 'package:wildwest_flutter/misc/size_utils.dart';
import 'package:wildwest_flutter/widgets/card.dart';

class HandWidget extends StatelessWidget {
  static const double CARD_WIDTH = 96;
  static const double CARD_HEIGHT = 144;

  @override
  Widget build(BuildContext context) {
    final itemsCount = 2;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          itemsCount,
          (index) => CardWidget(
            name: 'card $index',
            size: Size(
                SizeUtils.itemWidthInARow(context, itemsCount, CARD_WIDTH),
                CARD_HEIGHT),
            sizeWhenDragging: Size(CARD_WIDTH, CARD_HEIGHT),
          ),
        ),
      ),
    );
  }
}
