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
    state.player(id: player).health -= 1;
    return state;
  }

  @override
  double duration() => 1.0;
}
