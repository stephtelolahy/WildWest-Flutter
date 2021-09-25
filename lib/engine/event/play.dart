part of 'event.dart';

class GEventPlay extends GEvent {
  final GMove move;

  GEventPlay({
    required this.move,
  });

  @override
  List<Object?> get props => [move];

  @override
  GState dispatch(GState aState) {
    final state = GState.copy(aState);
    state.played.add(move.ability);
    state.history.add(move);
    return state;
  }

  @override
  Duration duration() => Duration();
}
