part of 'event.dart';

class GEventSetPhase extends GEvent {
  final int phase;

  @override
  List<Object?> get props => [phase];

  GEventSetPhase({
    required this.phase,
  });

  @override
  GState? dispatch(GState aState) {
    final state = GState.copy(aState);
    state.phase = phase;
    return state;
  }

  @override
  double duration() => 1.0;
}
