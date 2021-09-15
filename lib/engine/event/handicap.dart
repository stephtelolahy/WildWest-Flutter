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
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}
