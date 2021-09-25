part of 'event.dart';

class GEventEliminate extends GEvent {
  final String player;

  GEventEliminate({
    required this.player,
  });

  @override
  List<Object?> get props => [player];

  @override
  GState? dispatch(GState aState) {
    throw UnimplementedError();
  }
}
