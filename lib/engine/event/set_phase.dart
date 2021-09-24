part of 'event.dart';

class GEventSetPhase extends GEvent {
  final int phase;

  @override
  List<Object?> get props => [phase];

  GEventSetPhase({
    required this.phase,
  });

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }
}
