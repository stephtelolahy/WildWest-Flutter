part of 'event.dart';

class GEventDrawStore extends GEvent {
  final String player;
  final String card;

  GEventDrawStore({
    required this.player,
    required this.card,
  });

  @override
  List<Object?> get props => [player, card];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }
}
