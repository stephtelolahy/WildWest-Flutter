part of 'event.dart';

class GEventEliminate extends GEvent {
  final String player;

  GEventEliminate({
    required this.player,
  });

  @override
  List<Object?> get props => [player];

  @override
  GState? dispatch(GState aState) {
    final state = GState.copy(aState);
    state.playOrder.remove(player);
    state.player(id: player).health = 0;
    final hit = state.hit;
    if (hit != null) {
      hit.players.removeWhere((e) => e == player);
      if (hit.players.isEmpty) {
        state.hit = null;
      }
    }

    return state;
  }

  @override
  Duration? duration() => DEFAULT_EVENT_DURATION;
}
