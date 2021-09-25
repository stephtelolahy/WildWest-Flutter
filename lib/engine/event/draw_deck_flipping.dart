part of 'event.dart';

class GEventDrawDeckFlipping extends GEvent {
  final String player;

  GEventDrawDeckFlipping({
    required this.player,
  });

  @override
  List<Object?> get props => [player];

  @override
  GState? dispatch(GState aState) {
    throw UnimplementedError();
  }
}
