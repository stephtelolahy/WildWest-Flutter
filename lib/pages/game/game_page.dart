import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../engine/state/state.dart';
import '../../misc/size_utils.dart';
import 'cubit/game_cubit.dart';
import 'widgets/animated_card.dart';
import 'widgets/card.dart';
import 'widgets/player.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameCubit()..load(),
      child: _GameView(),
    );
  }
}

class _GameView extends StatelessWidget {
  static const double DECK_WIDTH = 60;

  final _keyPlayground = GlobalKey();
  final _keyDeck = GlobalKey();
  final _keyDiscard = GlobalKey();
  final _keyYou = GlobalKey();
  final _keyAnimated = GlobalKey<AnimatedCardState>();
  final _keyHand = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameCubit, GameState>(
      builder: (context, state) => Scaffold(
        body: Stack(
          children: [
            SafeArea(child: _buildState(context, state)),
            AnimatedCard(key: _keyAnimated),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<GameCubit>().loop(), //_showActions(context),
          child: Icon(Icons.play_arrow_outlined),
        ),
      ),
      listener: (context, state) => _handleEvent(context, state),
    );
  }

  Widget _buildState(BuildContext context, GameState state) {
    if (state is GameStateLoading) {
      return Container(child: Center(child: CircularProgressIndicator()));
    } else if (state is GameStateLoaded) {
      return _buildGameBoard(context, state);
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _buildGameBoard(BuildContext context, GameStateLoaded state) {
    return Column(
      children: [
        _buildOthers(state.others, context),
        _buildPlayground(context, discard: state.discard),
        _buildYou(context, state.you),
        _buildHand(context, state.you.hand),
      ],
    );
  }

  Widget _buildOthers(List<GPlayer> players, BuildContext context) {
    final maxWidth = SizeUtils.maxItemWidthInARow(context, players.length);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: players.map((e) => PlayerWidget(player: e, maxWidth: maxWidth)).toList(),
      ),
    );
  }

  Widget _buildPlayground(BuildContext context, {GCard? discard}) {
    return Expanded(
      key: _keyPlayground,
      child: DragTarget(
        onWillAccept: (data) => true,
        onAcceptWithDetails: (details) {
          /*
          final playgroundOffset = _keyPlayground.offset();
          final centerX = playgroundOffset.dx + details.offset.dx + CardWidget.CARD_WIDTH / 2;
          final draggingDY = CardWidget.CARD_DRAGGING_HEIGHT * CardWidget.CARD_DRAGGING_SHIFT_Y;
          final centerY =
              playgroundOffset.dx + details.offset.dy + CardWidget.CARD_HEIGHT / 2 + draggingDY;
          final center = Offset(centerX, centerY);
          final card = details.data as String;
          context.read<GameCubit>().play(card: card, center: center);
          */
        },
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
                    alignment: Alignment.center,
                    child: _buildDiscard(context, discard),
                  ),
                ],
              ));
        },
      ),
    );
  }

  Widget _buildDeck(BuildContext context) {
    return CardWidget(
      key: _keyDeck,
      name: 'deck',
      maxWidth: DECK_WIDTH,
    );
  }

  Widget _buildDiscard(BuildContext context, GCard? card) {
    return Container(
      key: _keyDiscard,
      width: CardWidget.CARD_WIDTH,
      height: CardWidget.CARD_HEIGHT,
      child: card != null ? CardWidget(name: card.id) : null,
    );
  }

  Widget _buildYou(BuildContext context, GPlayer player) {
    return Container(
      child: Row(
        children: [
          _buildMessage(context),
          PlayerWidget(key: _keyYou, player: player),
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

  Widget _buildHand(BuildContext context, List<GCard> cards) {
    final maxWidth = SizeUtils.maxItemWidthInARow(context, cards.length);
    return Container(
      key: _keyHand,
      height: CardWidget.CARD_HEIGHT,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          cards.length,
          (index) => CardWidget(name: cards[index].id, maxWidth: maxWidth, draggable: true),
        ),
      ),
    );
  }

  void _handleEvent(BuildContext context, GameState state) {
    /*
    final event = state.event;
    if (event is GameEventPlay) {
      _keyAnimated.currentState?.animate(
          duration: event.duration, card: event.card, from: event.center, to: _keyDiscard.center());
    } else if (event is GameEventDrawDeck) {
      _keyAnimated.currentState?.animate(
        duration: event.duration,
        card: event.card,
        from: _keyDeck.center(),
        to: _keyHand.center(),
      );
    } else if (event is GameEventDiscardHand) {
      _keyAnimated.currentState?.animate(
          duration: event.duration,
          card: event.card,
          from: _keyHand.center(),
          to: _keyDiscard.center());
    }
    */
  }

  void _showActions(BuildContext context) {
    /*
    final actions = ['drawDeck', 'discardHand'];

    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Title'),
        message: const Text('Message'),
        actions: actions
            .map((e) => CupertinoActionSheetAction(
                  child: Text(e),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(e);
                  },
                ))
            .toList(),
      ),
    ).then((value) {
      if (value == 'drawDeck') {
        context.read<GameCubit>().drawDeck();
      } else if (value == 'discardHand') {
        context.read<GameCubit>().discardHand();
      }
    });
    */
  }
}
