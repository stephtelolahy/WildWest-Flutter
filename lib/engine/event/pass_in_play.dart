part of 'event.dart';

class GEventPassInPlay extends GEvent {
  final String player;
  final String card;
  final String other;

  GEventPassInPlay({
    required this.player,
    required this.card,
    required this.other,
  });

  @override
  List<Object?> get props => [player, card, other];

  @override
  GState? dispatch(GState aState) {
    final state = GState.copy(aState);
    final playerObject = state.player(id: player);
    final index = playerObject.inPlay.indexWhere((e) => e.id == card);
    final cardObject = playerObject.inPlay.removeAt(index);
    final otherObject = state.player(id: other);
    otherObject.inPlay.add(cardObject);
    return state;
  }

  @override
  Duration? duration() => DEFAULT_EVENT_DURATION;
}
