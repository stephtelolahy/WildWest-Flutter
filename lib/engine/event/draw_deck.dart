part of 'event.dart';

class GEventDrawDeck extends GEvent {
  final String player;

  GEventDrawDeck({
    required this.player,
  });

  @override
  List<Object?> get props => [player];

  @override
  GState? dispatch(GState aState) {
    final state = GState.copy(aState);
    final card = state.deck.removeAt(0);
    state.player(identifier: player).hand.add(card);
    return state;
  }
}
