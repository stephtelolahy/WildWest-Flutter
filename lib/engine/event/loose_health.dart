part of 'event.dart';

class GEventLooseHealth extends GEvent {
  final String player;

  GEventLooseHealth({
    required this.player,
  });

  @override
  List<Object?> get props => [player];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }
}
