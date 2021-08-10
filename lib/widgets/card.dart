import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String name;
  final double width;
  final double height;

  CardWidget({required this.name, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: "data",
      childWhenDragging: Container(
        height: height,
        width: width,
        child: Card(
          elevation: 2.0,
          color: Colors.grey,
          child: Center(
            child: Text("empty"),
          ),
        ),
      ),
      feedback: Container(
          height: height,
          width: width,
          child: Card(
            elevation: 2.0,
            color: Colors.blue,
            child: Center(
              child: Text(name),
            ),
          )),
      child: Container(
        height: height,
        width: width,
        child: Card(
          elevation: 2.0,
          color: Colors.blue,
          child: Center(child: Text(name)),
        ),
      ),
    );
  }
}