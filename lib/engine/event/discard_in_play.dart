part of 'event.dart';

class GEventDiscardInPlay extends GEvent {
  final String player;
  final String card;

  GEventDiscardInPlay({
    required this.player,
    required this.card,
  });

  @override
  List<Object?> get props => [player, card];

  @override
  GState? dispatch(GState aState) {
    throw UnimplementedError();
  }

  @override
  Duration? duration() {
    throw UnimplementedError();
  }
}
