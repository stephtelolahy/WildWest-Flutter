part of 'event.dart';

class GEventPlay extends GEvent {
  final GMove move;

  GEventPlay({
    required this.move,
  });

  @override
  List<Object?> get props => [move];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }

  @override
  Duration duration() {
    throw UnimplementedError();
  }
}
