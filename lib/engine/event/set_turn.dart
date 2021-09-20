part of 'event.dart';

class GEventSetTurn extends GEvent {
  final String player;

  @override
  List<Object?> get props => [player];

  GEventSetTurn({
    required this.player,
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
