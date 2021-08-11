import 'package:flutter/material.dart';
import 'package:wildwest_flutter/pages/game/cubit/game_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscardWidget extends StatelessWidget {
  static const double CARD_WIDTH = 60;
  static const double CARD_HEIGHT = 80;

  final int deckCount;
  final String? topDiscard;

  DiscardWidget({required this.deckCount, required this.topDiscard});

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
                    child: _buildDeck(context),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: _buildDiscard(context),
                  ),
                ],
              ));
        },
      ),
    );
  }

  Widget _buildDeck(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.blue, fixedSize: Size(CARD_WIDTH, CARD_HEIGHT)),
      onPressed: () => context.read<GameCubit>().draw(),
      child: Text("Deck ($deckCount)"),
    );
  }

  Widget _buildDiscard(BuildContext context) {
    final card = topDiscard;
    if (card != null) {
      return Container(
        color: Colors.blue,
        child: Center(
          child: Text(card),
        ),
        width: CARD_WIDTH,
        height: CARD_HEIGHT,
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
