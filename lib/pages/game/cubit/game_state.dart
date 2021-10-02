part of 'game_cubit.dart';

@immutable
class GameState {
  final GState gState;
  final List<GPlayer> others;
  final GPlayer you;
  final GCard? discard;
  final GEvent? event;

  GameState({
    required this.gState,
    required this.others,
    required this.you,
    this.discard,
    this.event,
  });
}
