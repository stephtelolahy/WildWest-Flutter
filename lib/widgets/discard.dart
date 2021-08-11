import 'package:flutter/material.dart';

class DiscardWidget extends StatelessWidget {
  static const double CARD_WIDTH = 60;
  static const double CARD_HEIGHT = 80;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DragTarget(
        onWillAccept: (data) => true,
        builder: (context, candidateItems, rejectedItems) {
          final highlighted = candidateItems.isNotEmpty;
          final color = highlighted ? Colors.green : Colors.transparent;
          return Container(
              color: color,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            fixedSize: Size(CARD_WIDTH, CARD_HEIGHT)),
                        onPressed: () {},
                        child: Text("Deck")),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      color: Colors.blue,
                      child: Center(
                        child: Text('discard'),
                      ),
                      width: CARD_WIDTH,
                      height: CARD_HEIGHT,
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
