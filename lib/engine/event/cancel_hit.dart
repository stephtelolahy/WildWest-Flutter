part of 'event.dart';

class GEventCancelHit extends GEvent {
  final String player;

  GEventCancelHit({
    required this.player,
  });

  @override
  List<Object?> get props => [player];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}
