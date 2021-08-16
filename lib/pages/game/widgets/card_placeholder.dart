import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wildwest_flutter/pages/game/widgets/card.dart';

class CardPlaceholder extends StatelessWidget {
  final double maxWidth;

  CardPlaceholder({Key? key, required this.maxWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = min(CardWidget.CARD_WIDTH, maxWidth);
    return Container(
      height: CardWidget.CARD_HEIGHT,
      width: width,
    );
  }
}
