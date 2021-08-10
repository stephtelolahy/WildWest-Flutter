import 'package:flutter/material.dart';

class PlayerWidget extends StatelessWidget {
  final String name;
  final double width;
  final double height;

  PlayerWidget({required this.name, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      onWillAccept: (data) => true,
      onMove: (arg) {
        print("onMove ${arg.data} on $name");
      },
      builder: (context, data1, data2) {
        return Container(
          width: width,
          height: height,
          child: Card(
            child: Center(
              child: Text(name, textAlign: TextAlign.center),
            ),
          ),
        );
      },
    );
  }
}
