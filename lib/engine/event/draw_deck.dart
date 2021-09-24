part of 'event.dart';

class GEventDrawDeck extends GEvent {
  final String player;

  GEventDrawDeck({
    required this.player,
  });

  @override
  List<Object?> get props => [player];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }
}
