part of 'event.dart';

class GEventDrawInPlay extends GEvent {
  final String player;
  final String other;
  final String card;

  GEventDrawInPlay({
    required this.player,
    required this.other,
    required this.card,
  });

  @override
  List<Object?> get props => [player, card];

  @override
  GState? dispatch(GState aState) {
    final state = GState.copy(aState);
    final index = state.player(id: other).inPlay.indexWhere((e) => e.id == card);
    final cardObject = state.player(id: other).inPlay.removeAt(index);
    state.player(id: player).hand.add(cardObject);
    return state;
  }

  @override
  Duration? duration() => DEFAULT_EVENT_DURATION;
}
