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
    state.resetDeckIfNeeded();
    final card = state.deck.removeAt(0);
    state.player(id: player).hand.add(card);
    return state;
  }

  @override
  double duration() => 1.0;
}

extension ResettingDeck on GState {
  void resetDeckIfNeeded() {
    final minDeck = 2;
    final minDiscard = 2;
    if (deck.length <= minDeck && discard.length >= minDiscard) {
      final cards = List<GCard>.from(discard);
      discard = [cards.removeLast()];
      cards.shuffle();
      deck.addAll(cards);
    }
  }
}
