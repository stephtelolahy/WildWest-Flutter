part of 'event.dart';

class GEventReverseHit extends GEvent {
  @override
  GState dispatch(GState aState) {
    final hit = aState.hit;
    if (hit == null) {
      throw UnsupportedError('Missing hit');
    }

    final state = GState.copy(aState);
    state.hit = GHit(
      name: hit.name,
      players: hit.targets,
      abilities: hit.abilities,
      targets: hit.players,
    );
    return state;
  }

  @override
  List<Object?> get props => [];
}
