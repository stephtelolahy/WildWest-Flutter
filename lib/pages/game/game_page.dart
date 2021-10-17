import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../engine/event/event.dart';
import '../../engine/state/state.dart';
import '../../misc/size_utils.dart';
import 'game_controller.dart';
import 'widgets/animated_card.dart';
import 'widgets/card.dart';
import 'widgets/player.dart';

class GamePage extends StatelessWidget {
  final _keyPlayground = GlobalKey();
  final _keyDeck = GlobalKey();
  final _keyDiscard = GlobalKey();
  final _keyPlayers = List.generate(8, (_) => GlobalKey());
  final _keyAnimated = GlobalKey<AnimatedCardState>();
  final _keyHand = GlobalKey();

  final _gameController = Get.put(GameController());

  @override
  Widget build(BuildContext context) {
    _gameController.event.listen((anEvent) {
      final event = anEvent!;
      final state = _gameController.state.value!;
      _animateEvent(context, event, state);
    });

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Obx(() {
              final state = _gameController.state.value;
              if (state == null) {
                return Container(child: Center(child: CircularProgressIndicator()));
              } else {
                return Column(
                  children: [
                    _buildOthers(context, _gameController.others, state),
                    _buildPlayground(context, discard: _gameController.discard),
                    _buildYou(context, _gameController.you, state),
                    _buildHand(context, _gameController.you.hand),
                  ],
                );
              }
            }),
          ),
          AnimatedCard(key: _keyAnimated),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _gameController.run(),
        child: Icon(Icons.play_arrow_outlined),
      ),
    );
  }

  Widget _buildOthers(BuildContext context, List<GPlayer> players, GState state) {
    final maxWidth = SizeUtils.maxItemWidthInARow(context, players.length);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: players
            .map((e) => PlayerWidget(
                  key: _keyPlayers[state.players.indexOf(e)],
                  player: e,
                  maxWidth: maxWidth,
                  highlight: state.highlightFor(e),
                ))
            .toList(),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDeck(context),
                  _buildDiscard(context, discard),
                ],
              ));
        },
      ),
    );
  }

  Widget _buildDeck(BuildContext context) {
    return CardWidget(
      key: _keyDeck,
      card: GCard(),
    );
  }

  Widget _buildDiscard(BuildContext context, GCard? card) {
    return Container(
      key: _keyDiscard,
      width: CardWidget.CARD_WIDTH,
      height: CardWidget.CARD_HEIGHT,
      child: card != null ? CardWidget(card: card) : null,
    );
  }

  Widget _buildYou(BuildContext context, GPlayer player, GState state) {
    return Container(
      child: Row(
        children: [
          _buildMessage(context, state),
          PlayerWidget(
            key: _keyPlayers[state.players.indexOf(player)],
            player: player,
            highlight: state.highlightFor(player),
            showInPlayUp: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(BuildContext context, GState state) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.all(8),
      child: Center(
          child: Text(
        state.message(),
      )),
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
          (index) => CardWidget(card: cards[index], maxWidth: maxWidth, draggable: true),
        ),
      ),
    );
  }

  void _animateEvent(BuildContext context, GEvent event, GState state) {
    if (event.duration() == 0) {
      return;
    }

    // TODO: set duration in event
    final duration = Duration(milliseconds: (event.duration() * 400).toInt());

    if (event is GEventDeckToStore) {
      final cardId = state.deck.first.id;
      _keyAnimated.currentState?.animate(
        duration: duration,
        cardId: cardId,
        from: _keyDeck.center(),
        to: _keyDeck.center(),
      );
    } else if (event is GEventDiscardHand) {
      final actorKey = _keyPlayers[state.players.indexWhere((e) => e.id == event.player)];
      _keyAnimated.currentState?.animate(
        duration: duration,
        cardId: event.card,
        from: actorKey.center(),
        to: _keyDiscard.center(),
      );
    } else if (event is GEventDiscardInPlay) {
      final actorKey = _keyPlayers[state.players.indexWhere((e) => e.id == event.player)];
      _keyAnimated.currentState?.animate(
        duration: duration,
        cardId: event.card,
        from: actorKey.center(),
        to: _keyDiscard.center(),
      );
    } else if (event is GEventDrawDeck) {
      final actorKey = _keyPlayers[state.players.indexWhere((e) => e.id == event.player)];
      _keyAnimated.currentState?.animate(
        duration: duration,
        cardId: null,
        from: _keyDeck.center(),
        to: actorKey.center(),
      );
    } else if (event is GEventDrawDeckCard) {
      final actorKey = _keyPlayers[state.players.indexWhere((e) => e.id == event.player)];
      _keyAnimated.currentState?.animate(
        duration: duration,
        cardId: null,
        from: _keyDeck.center(),
        to: actorKey.center(),
      );
    } else if (event is GEventDrawDiscard) {
      final actorKey = _keyPlayers[state.players.indexWhere((e) => e.id == event.player)];
      final cardId = state.discard.last.id;
      _keyAnimated.currentState?.animate(
        duration: duration,
        cardId: cardId,
        from: _keyDiscard.center(),
        to: actorKey.center(),
      );
    } else if (event is GEventDrawHand) {
      final actorKey = _keyPlayers[state.players.indexWhere((e) => e.id == event.player)];
      final targetKey = _keyPlayers[state.players.indexWhere((e) => e.id == event.other)];
      _keyAnimated.currentState?.animate(
        duration: duration,
        cardId: null,
        from: targetKey.center(),
        to: actorKey.center(),
      );
    } else if (event is GEventDrawInPlay) {
      final actorKey = _keyPlayers[state.players.indexWhere((e) => e.id == event.player)];
      final targetKey = _keyPlayers[state.players.indexWhere((e) => e.id == event.other)];
      _keyAnimated.currentState?.animate(
        duration: duration,
        cardId: event.card,
        from: targetKey.center(),
        to: actorKey.center(),
      );
    } else if (event is GEventDrawStore) {
      final actorKey = _keyPlayers[state.players.indexWhere((e) => e.id == event.player)];
      _keyAnimated.currentState?.animate(
        duration: duration,
        cardId: event.card,
        from: _keyDeck.center(),
        to: actorKey.center(),
      );
    } else if (event is GEventEquip) {
      final actorKey = _keyPlayers[state.players.indexWhere((e) => e.id == event.player)];
      _keyAnimated.currentState?.animate(
        duration: duration,
        cardId: event.card,
        from: actorKey.center(),
        to: actorKey.center(),
      );
    } else if (event is GEventFlipDeck) {
      final cardId = state.deck.first.id;
      _keyAnimated.currentState?.animate(
        duration: duration,
        cardId: cardId,
        from: _keyDeck.center(),
        to: _keyDiscard.center(),
      );
    } else if (event is GEventFlipHand) {
      final actorKey = _keyPlayers[state.players.indexWhere((e) => e.id == event.player)];
      final cardId = state.player(id: event.player).hand.last.id;
      _keyAnimated.currentState?.animate(
        duration: duration,
        cardId: cardId,
        from: actorKey.center(),
        to: actorKey.center(),
      );
    } else if (event is GEventHandicap) {
      final actorKey = _keyPlayers[state.players.indexWhere((e) => e.id == event.player)];
      final targetKey = _keyPlayers[state.players.indexWhere((e) => e.id == event.other)];
      _keyAnimated.currentState?.animate(
        duration: duration,
        cardId: event.card,
        from: actorKey.center(),
        to: targetKey.center(),
      );
    } else if (event is GEventPassInPlay) {
      final actorKey = _keyPlayers[state.players.indexWhere((e) => e.id == event.player)];
      final targetKey = _keyPlayers[state.players.indexWhere((e) => e.id == event.other)];
      _keyAnimated.currentState?.animate(
        duration: duration,
        cardId: event.card,
        from: actorKey.center(),
        to: targetKey.center(),
      );
    } else {
      print('Missing animation for $event');
    }
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

extension Rendering on GState {
  Color? highlightFor(GPlayer aPlayer) {
    final hit = this.hit;
    if (hit != null && hit.players.any((e) => e == aPlayer.id)) {
      return hit.abilities.contains('looseHealth') ? Colors.red : Colors.blue;
    } else if (aPlayer.id == turn) {
      return Colors.amber;
    } else {
      return null;
    }
  }

  String message() {
    if (played.isNotEmpty) {
      return played.last;
    } else {
      return '';
    }
  }
}
