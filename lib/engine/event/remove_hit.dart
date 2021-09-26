part of 'event.dart';

class GEventRemoveHit extends GEvent {
  final String player;

  GEventRemoveHit({
    required this.player,
  });

  @override
  List<Object?> get props => [player];

  @override
  GState? dispatch(GState aState) {
    final state = GState.copy(aState);

    final hit = state.hit;
    if (hit == null) {
      throw UnsupportedError('Missing hit');
    }

    final index = hit.players.indexOf(player);
    if (index == -1) {
      throw UnsupportedError('Player not found');
    }

    hit.players.removeAt(index);

    if (index < hit.targets.length) {
      hit.targets.removeAt(index);
    }

    if (hit.players.isEmpty) {
      state.hit = null;
    }

    return state;
  }
}
