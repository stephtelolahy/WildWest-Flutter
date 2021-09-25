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
    throw UnimplementedError();
  }
}
