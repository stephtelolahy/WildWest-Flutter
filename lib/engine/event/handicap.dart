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
  GState? dispatch(GState aState) {
    final state = GState.copy(aState);
    final playerObject = state.player(id: player);
    final index = playerObject.hand.indexWhere((e) => e.id == card);
    final cardObject = playerObject.hand.removeAt(index);
    final otherObject = state.player(id: other);
    otherObject.inPlay.add(cardObject);
    return state;
  }

  @override
  double duration() => 1.0;
}
