part of 'event.dart';

class GEventSetHit extends GEvent {
  final GHit hit;

  GEventSetHit({
    required this.hit,
  });

  @override
  List<Object?> get props => [hit];

  @override
  GState? dispatch(GState aState) {
    if (aState.hit != null) {
      throw UnsupportedError('A hit is already settled');
    }

    final state = GState.copy(aState);
    state.hit = hit;
    return state;
  }

  @override
  Duration? duration() => DEFAULT_EVENT_DURATION;
}
