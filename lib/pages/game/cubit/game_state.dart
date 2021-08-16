part of 'game_cubit.dart';

@immutable
class GameState {
  final String? played;
  final List<String> discard;
  final List<String?> hand;
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

abstract class GameEvent {}

class GameEventDraw extends GameEvent {
  final String card;

  GameEventDraw({required this.card});
}

class GameEventPlay extends GameEvent {}
