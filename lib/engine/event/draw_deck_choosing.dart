part of 'event.dart';

class GEventDrawDeckChoosing extends GEvent {
  final String player;
  final String card;

  GEventDrawDeckChoosing({
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
  Duration? duration() => DEFAULT_EVENT_DURATION;
}
