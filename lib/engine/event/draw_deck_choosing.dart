part of 'event.dart';

class GEventDrawDeckChoosing extends GEvent {
  final String player;
  final String card;

  GEventDrawDeckChoosing({
    required this.player,
    required this.card,
  });

  @override
  List<Object?> get props => [player, card];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}
