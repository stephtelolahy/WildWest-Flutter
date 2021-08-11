import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wildwest_flutter/pages/game/cubit/game_cubit.dart';

class DiscardWidget extends StatelessWidget {
  static const double CARD_WIDTH = 60;
  static const double CARD_HEIGHT = 80;

  final String? discard;

  DiscardWidget({required this.discard});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DragTarget(
        onWillAccept: (data) => true,
        onAccept: (data) => context.read<GameCubit>().play(data as String),
        builder: (context, candidateItems, rejectedItems) {
          final highlighted = candidateItems.isNotEmpty;
          final color = highlighted ? Colors.white12 : Colors.transparent;
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
      child: Text("Deck"),
    );
  }

  Widget _buildDiscard(BuildContext context) {
    final card = discard;
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
