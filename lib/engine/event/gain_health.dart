part of 'event.dart';

class GEventGainHealth extends GEvent {
  final String player;

  @override
  List<Object?> get props => [player];

  GEventGainHealth({
    required this.player,
  });

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }
}
