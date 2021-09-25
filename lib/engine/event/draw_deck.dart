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
    _resetDeckIfNeeded(state);
    final card = state.deck.removeAt(0);
    state.player(id: player).hand.add(card);
    return state;
  }

  void _resetDeckIfNeeded(GState state) {
    final minDeck = 2;
    final minDiscard = 2;
    if (state.deck.length <= minDeck && state.discard.length >= minDiscard) {
      final cards = List<GCard>.from(state.discard);
      state.discard = [cards.removeLast()];
      cards.shuffle();
      state.deck.addAll(cards);
    }
  }
}
