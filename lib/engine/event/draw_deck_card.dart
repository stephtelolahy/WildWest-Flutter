part of 'event.dart';

class GEventDrawDeckCard extends GEvent {
  final String player;
  final String card;

  GEventDrawDeckCard({
    required this.player,
    required this.card,
  });

  @override
  List<Object?> get props => [player, card];

  @override
  GState? dispatch(GState aState) {
    final state = GState.copy(aState);
    final index = state.deck.indexWhere((e) => e.id == card);
    final cardObject = state.deck.removeAt(index);
    state.player(id: player).hand.add(cardObject);
    return state;
  }

  @override
  double duration() => 1.0;
}
