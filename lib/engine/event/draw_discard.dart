part of 'event.dart';

class GEventDrawDiscard extends GEvent {
  final String player;

  GEventDrawDiscard({
    required this.player,
  });

  @override
  List<Object?> get props => [player];

  @override
  GState? dispatch(GState aState) {
    final state = GState.copy(aState);
    final card = state.discard.removeLast();
    state.player(id: player).hand.add(card);
    return state;
  }

  @override
  double duration() => 1.0;
}
