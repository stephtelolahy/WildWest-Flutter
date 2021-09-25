part of 'event.dart';

class GEventLooseHealth extends GEvent {
  final String player;

  GEventLooseHealth({
    required this.player,
  });

  @override
  List<Object?> get props => [player];

  @override
  GState? dispatch(GState aState) {
    final state = GState.copy(aState);
    state.player(identifier: player).health -= 1;
    return state;
  }

  @override
  Duration? duration() => DEFAULT_EVENT_DURATION;
}
