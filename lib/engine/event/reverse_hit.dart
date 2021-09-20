part of 'event.dart';

class GEventReverseHit extends GEvent {
  final String player;

  GEventReverseHit({required this.player});

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [player];
}
