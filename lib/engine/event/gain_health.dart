part of 'event.dart';

class GEventGainHealth extends GEvent {
  final String player;

  @override
  List<Object?> get props => [player];

  GEventGainHealth({
    required this.player,
  });

  @override
  GState? dispatch(GState aState) {
    final state = GState.copy(aState);
    state.player(identifier: player).health += 1;
    return state;
  }

  @override
  Duration? duration() => DEFAULT_EVENT_DURATION;
}
