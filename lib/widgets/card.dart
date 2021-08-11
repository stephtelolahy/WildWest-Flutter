import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String name;
  final double width;
  final double height;
  final double floatingWidth;

  CardWidget(
      {required this.name,
      required this.width,
      required this.floatingWidth,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: name,
      childWhenDragging: SizedBox.shrink(),
      feedback: Transform.scale(
          scale: 1.2,
          child: Container(
              height: height,
              width: floatingWidth,
              child: Card(
                elevation: 2.0,
                color: Colors.amber,
                child: Center(
                  child: Text(name),
                ),
              ))),
      child: Container(
        height: height,
        width: width,
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: Colors.blue,
          child: Center(child: Text(name)),
        ),
      ),
    );
  }
}
