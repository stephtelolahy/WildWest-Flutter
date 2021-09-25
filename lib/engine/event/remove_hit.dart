part of 'event.dart';

class GEventRemoveHit extends GEvent {
  final String player;

  GEventRemoveHit({
    required this.player,
  });

  @override
  List<Object?> get props => [player];

  @override
  GState dispatch(GState aState) {
    final hit = aState.hit;
    if (hit == null) {
      throw UnsupportedError('Missing hit');
    }

    final index = hit.players.indexOf(player);
    if (index == -1) {
      throw UnsupportedError('Player not found');
    }

    final state = GState.copy(aState);
    hit.players.removeAt(index);

    if (index < hit.targets.length) {
      hit.targets.removeAt(index);
    }

    if (hit.players.isNotEmpty) {
      state.hit = hit;
    } else {
      state.hit = null;
    }

    return state;
  }
}
