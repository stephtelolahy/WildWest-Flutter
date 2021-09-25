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
    throw UnimplementedError();
  }
}
