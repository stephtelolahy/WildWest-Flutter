import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wildwest_flutter/pages/game/cubit/game_cubit.dart';
import 'package:wildwest_flutter/pages/game/widgets/discard.dart';
import 'package:wildwest_flutter/pages/game/widgets/hand.dart';
import 'package:wildwest_flutter/pages/game/widgets/others.dart';
import 'package:wildwest_flutter/pages/game/widgets/you.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameCubit(),
      child: _GameView(),
    );
  }
}

class _GameView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<GameCubit, GameState>(
          builder: (context, state) => _buildGameBoard(context, state),
        ),
      ),
    );
  }

  Widget _buildGameBoard(BuildContext context, GameState state) {
    final topDiscard = state.discard.isNotEmpty ? state.discard.last : null;
    return Column(
      children: [
        OthersWidget(),
        DiscardWidget(
          deckCount: state.deck.length,
          topDiscard: topDiscard,
        ),
        YouWidget(),
        HandWidget(cards: state.hand),
      ],
    );
  }
}
