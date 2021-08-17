part of 'game_cubit.dart';

@immutable
class GameState {
  final String? played;
  final List<String> discard;
  final List<String> hand;
  final List<String> others;
  final GameEvent? event;

  GameState({
    required this.others,
    required this.played,
    required this.discard,
    required this.hand,
    required this.event,
  });
}

abstract class GameEvent {
  final Duration duration = Duration(milliseconds: 400);
}

class GameEventDrawDeck extends GameEvent {
  final String card;

  GameEventDrawDeck({required this.card});
}

class GameEventDiscardHand extends GameEvent {
  final String card;

  GameEventDiscardHand({required this.card});
}

class GameEventPlay extends GameEvent {
  final String card;
  final Offset center;

  GameEventPlay({required this.card, required this.center});
}
