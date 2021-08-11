part of 'game_cubit.dart';

@immutable
class GameState {
  final String? discard;
  final List<String> hand;

  GameState({this.discard, required this.hand});

  GameState.initial()
      : this.discard = null,
        this.hand = [];
}
