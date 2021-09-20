part of 'event.dart';

class GEventRemoveHit extends GEvent {
  final String player;

  GEventRemoveHit({
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
