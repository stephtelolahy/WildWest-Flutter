part of 'event.dart';

class GEventFlipHand extends GEvent {
  final String player;

  GEventFlipHand({required this.player});

  @override
  List<Object?> get props => [player];

  @override
  GState? dispatch(GState aState) => null;

  @override
  double duration() => 1.0;
}
