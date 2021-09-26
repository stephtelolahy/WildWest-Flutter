part of 'event.dart';

class GEventDrawStore extends GEvent {
  final String player;
  final String card;

  GEventDrawStore({
    required this.player,
    required this.card,
  });

  @override
  List<Object?> get props => [player, card];

  @override
  GState? dispatch(GState aState) {
    final state = GState.copy(aState);
    final index = state.store.indexWhere((e) => e.id == card);
    final cardObject = state.store.removeAt(index);
    state.player(id: player).hand.add(cardObject);
    return state;
  }

  @override
  double duration() => 1.0;
}
