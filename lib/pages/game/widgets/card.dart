import 'dart:math';

import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  static const double CARD_WIDTH = 96;
  static const double CARD_HEIGHT = 144;
  static const double CARD_ELEVATION = 2;
  static const double CARD_RADIUS = 4;
  static const double CARD_SCALE_WHEN_DRAGGING = 1.2;

  final String name;
  final double maxWidth;
  final bool draggable;

  CardWidget({
    Key? key,
    required this.name,
    this.maxWidth = CARD_WIDTH,
    this.draggable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return draggable ? _buildDraggable(context) : _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    final width = min(CARD_WIDTH, maxWidth);
    return Container(
      height: CARD_HEIGHT,
      width: width,
      child: Card(
        elevation: CARD_ELEVATION,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CARD_RADIUS)),
        color: Colors.blue,
        child: Center(child: Text(name, textAlign: TextAlign.center)),
      ),
    );
  }

  Widget _buildDraggable(BuildContext context) {
    final draggingDx =
        (maxWidth < CARD_WIDTH) ? (maxWidth - CARD_WIDTH) * 0.5 : 0.0;
    final draggingDY = -CARD_HEIGHT * 0.5;
    return Draggable(
        data: name,
        childWhenDragging: SizedBox.shrink(),
        feedback: Transform.scale(
          scale: CARD_SCALE_WHEN_DRAGGING,
          child: Transform.translate(
            offset: Offset(draggingDx, draggingDY),
            child: Container(
              height: CARD_HEIGHT,
              width: CARD_WIDTH,
              child: Card(
                elevation: CARD_ELEVATION,
                color: Colors.amber,
                child: Center(child: Text(name)),
              ),
            ),
          ),
        ),
        child: _buildContent(context));
  }
}
