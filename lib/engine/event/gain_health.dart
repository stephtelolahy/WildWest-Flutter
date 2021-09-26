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
    state.player(id: player).health += 1;
    return state;
  }

  @override
  double duration() => 1.0;
}
