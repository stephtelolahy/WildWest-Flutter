part of 'event.dart';

class GEventDiscardInPlay extends GEvent {
  final String player;
  final String card;

  GEventDiscardInPlay({
    required this.player,
    required this.card,
  });

  @override
  List<Object?> get props => [player, card];

  @override
  GState? dispatch(GState aState) {
    final state = GState.copy(aState);
    final playerObject = state.player(id: player);
    final index = playerObject.inPlay.indexWhere((e) => e.id == card);
    final cardObject = playerObject.inPlay.removeAt(index);
    state.discard.add(cardObject);
    return state;
  }

  @override
  double duration() => 1.0;
}
