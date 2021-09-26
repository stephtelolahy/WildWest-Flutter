part of 'event.dart';

class GEventDeckToStore extends GEvent {
  @override
  List<Object?> get props => [];
  @override
  GState? dispatch(GState aState) {
    final state = GState.copy(aState);
    state.resetDeckIfNeeded();
    final card = state.deck.removeAt(0);
    state.store.add(card);
    return state;
  }

  @override
  double duration() => 1.0;
}
