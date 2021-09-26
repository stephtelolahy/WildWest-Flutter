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
  GState? dispatch(GState aState) {
    final state = GState.copy(aState);
    final playerObject = state.player(id: player);
    final index = playerObject.hand.indexWhere((e) => e.id == card);
    final cardObject = playerObject.hand.removeAt(index);
    state.discard.insert(0, cardObject);
    return state;
  }

  @override
  Duration? duration() => DEFAULT_EVENT_DURATION;
}
