part of 'event.dart';

class GEventSetTurn extends GEvent {
  final String player;

  @override
  List<Object?> get props => [player];

  GEventSetTurn({
    required this.player,
  });

  @override
  GState dispatch(GState aState) {
    final state = GState.copy(aState);
    state.turn = player;
    state.played.clear();
    return state;
  }

  @override
  Duration duration() => DEFAULT_EVENT_DURATION;
}
