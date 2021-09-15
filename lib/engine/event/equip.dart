part of 'event.dart';

class GEventEquip extends GEvent {
  final String player;
  final String card;

  GEventEquip({
    required this.player,
    required this.card,
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
