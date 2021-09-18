part of 'event.dart';

class GEventDiscardHand extends GEvent {
  final String player;
  final String card;

  GEventDiscardHand({
    required this.player,
    required this.card,
  });

  @override
  List<Object?> get props => [player, card];

  @override
  GState dispatch(GState aState) {
    final state = GState.copy(aState);
    final playerObject = state.player(identifier: player);
    final handIndex = playerObject.hand.indexWhere((e) => e.identifier == card);
    final cardObject = playerObject.hand.removeAt(handIndex);
    state.discard.insert(0, cardObject);
    return state;
  }

  @override
  Duration duration() => GEvent.DEFAULT_DURATION;
}
