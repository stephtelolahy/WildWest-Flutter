import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wildwest_flutter/pages/game/cubit/game_cubit.dart';
import 'package:wildwest_flutter/pages/game/widgets/card.dart';

class PlaygroundWidget extends StatelessWidget {
  static const double DISCARD_WIDTH = 60;
  static const double DECK_WIDTH = 80;
  static const double DECK_HEIGHT = 80;

  final String? discard;
  final String? played;

  PlaygroundWidget({required this.discard, required this.played});

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
                    child: _buildDiscardedCardOrNull(context),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: _buildPlayedCardOrNull(context),
                  ),
                ],
              ));
        },
      ),
    );
  }

  Widget _buildDeck(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      onPressed: () => context.read<GameCubit>().draw(),
      child: Icon(Icons.add),
    );
  }

  Widget _buildPlayedCardOrNull(BuildContext context) {
    return played != null ? CardWidget(name: played!) : SizedBox.shrink();
  }

  Widget _buildDiscardedCardOrNull(BuildContext context) {
    return discard != null
        ? CardWidget(
            name: discard!,
            maxWidth: DISCARD_WIDTH,
          )
        : SizedBox.shrink();
  }
}
