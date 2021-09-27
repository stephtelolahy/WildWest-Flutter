part of 'game_cubit.dart';

@immutable
abstract class GameState {}

class GameStateLoading extends GameState {}

class GameStateLoaded extends GameState {
  final GState gState;
  final List<GPlayer> others;
  final GPlayer you;
  final GCard? discard;
  final GEvent? event;

  GameStateLoaded({
    required this.gState,
    required this.others,
    required this.you,
    this.discard,
    this.event,
  });
}
