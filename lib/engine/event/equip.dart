part of 'event.dart';

class GEventEquip extends GEvent {
  final String player;
  final String card;

  GEventEquip({
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
    playerObject.inPlay.add(cardObject);
    return state;
  }

  @override
  Duration? duration() => DEFAULT_EVENT_DURATION;
}
