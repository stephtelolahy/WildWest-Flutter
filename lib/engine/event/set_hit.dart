part of 'event.dart';

class GEventSetHit extends GEvent {
  final GHit hit;

  GEventSetHit({
    required this.hit,
  });

  @override
  List<Object?> get props => [hit];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }
}
