part of 'event.dart';

class GEventHandicap extends GEvent {
  final String player;
  final String card;
  final String other;

  GEventHandicap({
    required this.player,
    required this.card,
    required this.other,
  });

  @override
  List<Object?> get props => [player, card, other];

  @override
  GState dispatch(GState aState) {
    final state = GState.copy(aState);
    final playerObject = state.player(identifier: player);
    final handIndex = playerObject.hand.indexWhere((e) => e.identifier == card);
    final cardObject = playerObject.hand.removeAt(handIndex);
    final otherObject = state.player(identifier: other);
    otherObject.inPlay.add(cardObject);
    return state;
  }

  @override
  Duration duration() => GEvent.DEFAULT_DURATION;
}
