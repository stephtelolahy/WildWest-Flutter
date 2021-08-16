import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wildwest_flutter/misc/size_utils.dart';
import 'package:wildwest_flutter/pages/game/cubit/game_cubit.dart';
import 'package:wildwest_flutter/pages/game/widgets/animated_card.dart';
import 'package:wildwest_flutter/pages/game/widgets/card.dart';
import 'package:wildwest_flutter/pages/game/widgets/card_placeholder.dart';
import 'package:wildwest_flutter/pages/game/widgets/player.dart';

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
  static const double DISCARD_WIDTH = 60;

  final _keyDeck = GlobalKey();
  final _keyYou = GlobalKey();
  final _keyAnimated = GlobalKey<AnimatedCardState>();
  final _keysHand = List.generate(20, (index) => GlobalKey());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameCubit, GameState>(
      builder: (context, state) => Scaffold(
        body: Stack(
          children: [
            SafeArea(child: _buildGameBoard(context, state)),
            AnimatedCard(key: _keyAnimated)
          ],
        ),
      ),
      listener: (context, state) => SchedulerBinding.instance
          ?.addPostFrameCallback((_) => _handleEvent(context, state)),
    );
  }

  Widget _buildGameBoard(BuildContext context, GameState state) {
    return Column(
      children: [
        _buildOthers(context, state.others),
        _buildPlayground(context,
            discard: state.discard.lastOrNull, played: state.played),
        _buildYou(context),
        _buildHand(context, state.hand),
      ],
    );
  }

  Widget _buildOthers(BuildContext context, List<String> players) {
    final maxWidth = SizeUtils.maxItemWidthInARow(context, players.length);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: players
            .map((e) => PlayerWidget(name: e, maxWidth: maxWidth))
            .toList(),
      ),
    );
  }

  Widget _buildPlayground(BuildContext context,
      {String? discard, String? played}) {
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
                    child: _buildDiscardedCardOrNull(context, discard),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: _buildPlayedCardOrNull(context, played),
                  ),
                ],
              ));
        },
      ),
    );
  }

  Widget _buildDeck(BuildContext context) {
    return FloatingActionButton(
      key: _keyDeck,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      onPressed: () => context.read<GameCubit>().draw(),
      child: Icon(Icons.add),
    );
  }

  Widget _buildPlayedCardOrNull(BuildContext context, String? card) {
    return card != null ? CardWidget(name: card) : SizedBox.shrink();
  }

  Widget _buildDiscardedCardOrNull(BuildContext context, String? card) {
    return card != null
        ? CardWidget(name: card, maxWidth: DISCARD_WIDTH)
        : SizedBox.shrink();
  }

  Widget _buildYou(BuildContext context) {
    return Container(
      child: Row(
        children: [
          _buildMessage(context),
          PlayerWidget(key: _keyYou, name: 'you'),
        ],
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    final message =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque at sodales augue. Maecenas consequat odio in enim fringilla, id dapibus neque commodo.";
    return Expanded(
        child: Padding(
      padding: EdgeInsets.all(8),
      child: Text(message),
    ));
  }

  Widget _buildHand(BuildContext context, List<String?> cards) {
    final maxWidth = SizeUtils.maxItemWidthInARow(context, cards.length);
    return Container(
      height: CardWidget.CARD_HEIGHT,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          cards.length,
          (index) {
            final name = cards[index];
            final key = _keysHand[index];
            if (name != null) {
              return CardWidget(
                  key: key, name: name, maxWidth: maxWidth, draggable: true);
            } else {
              return CardPlaceholder(key: key, maxWidth: maxWidth);
            }
          },
        ),
      ),
    );
  }

  void _handleEvent(BuildContext context, GameState state) {
    final event = state.event;
    if (event is GameEventDraw) {
      final keyTarget = _keysHand[state.hand.length - 1];
      _keyAnimated.currentState
          ?.animate(card: event.card, fromKey: _keyDeck, toKey: keyTarget)
          .then((_) => context.read<GameCubit>().completeCurrentEvent());
    }
  }
}
