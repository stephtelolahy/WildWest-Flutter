import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  static const double CARD_ELEVATION = 2;
  static const double CARD_RADIUS = 4;
  static const double CARD_SCALE_WHEN_DRAGGING = 1.2;

  final String name;
  final Size size;
  final Size sizeWhenDragging;

  CardWidget(
      {required this.name, required this.size, required this.sizeWhenDragging});

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: name,
      childWhenDragging: SizedBox.shrink(),
      feedback: Transform.scale(
          scale: CARD_SCALE_WHEN_DRAGGING,
          child: Transform.translate(
              offset: Offset((size.width - sizeWhenDragging.width) * 0.5,
                  -size.height * 0.5),
              child: Container(
                  height: sizeWhenDragging.height,
                  width: sizeWhenDragging.width,
                  child: Card(
                    elevation: CARD_ELEVATION,
                    color: Colors.amber,
                    child: Center(
                      child: Text(name),
                    ),
                  )))),
      child: Container(
        height: size.height,
        width: size.width,
        child: Card(
          elevation: CARD_ELEVATION,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(CARD_RADIUS)),
          color: Colors.blue,
          child: Center(child: Text(name)),
        ),
      ),
    );
  }
}
