part of 'event.dart';

class GEventDrawDiscard extends GEvent {
  final String player;

  GEventDrawDiscard({
    required this.player,
  });

  @override
  List<Object?> get props => [player];

  @override
  GState? dispatch(GState aState) {
    throw UnimplementedError();
  }
}
