part of 'event.dart';

class GEventDrawHand extends GEvent {
  final String player;
  final String other;
  final String card;

  GEventDrawHand({
    required this.player,
    required this.other,
    required this.card,
  });

  @override
  List<Object?> get props => [player, other, card];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }
}
