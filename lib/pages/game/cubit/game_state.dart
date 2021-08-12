part of 'game_cubit.dart';

@immutable
class GameState {
  final String? played;
  final List<String> discard;
  final List<String> hand;
  final List<String> others;

  GameState({
    required this.others,
    required this.played,
    required this.discard,
    required this.hand,
  });
}
