part of 'event.dart';

class GEventFlipDeck extends GEvent {
  @override
  List<Object?> get props => [];

  @override
  GState? dispatch(GState aState) {
    final state = GState.copy(aState);
    state.resetDeckIfNeeded();
    final card = state.deck.removeAt(0);
    state.discard.add(card);
    return state;
  }

  @override
  Duration? duration() => DEFAULT_EVENT_DURATION;
}
