part of 'event.dart';

class GEventPlay extends GEvent {
  final String player;
  final String card;

  GEventPlay({
    required this.player,
    required this.card,
  });

  @override
  GState dispatch(GState aState) {
    final state = GState.copy(aState);
    final playerObject =
        state.players.firstWhere((e) => e.identifier == player);
    final handIndex = playerObject.hand.indexWhere((e) => e.identifier == card);
    final cardObject = playerObject.hand.removeAt(handIndex);
    state.discard.insert(0, cardObject);
    return state;
  }

  @override
  Duration duration() {
    return GEvent.DEFAULT_DURATION;
  }
}
