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
  GState dispatch(GState aState) {
    final state = GState.copy(aState);
    final playerObject = state.player(identifier: player);
    final handIndex = playerObject.hand.indexWhere((e) => e.identifier == card);
    final cardObject = playerObject.hand.removeAt(handIndex);
    playerObject.inPlay.add(cardObject);
    return state;
  }

  @override
  Duration duration() => DEFAULT_EVENT_DURATION;
}
