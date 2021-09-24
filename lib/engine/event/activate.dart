part of 'event.dart';

class GEventActivate extends GEvent {
  final List<GMove> moves;

  GEventActivate({
    required this.moves,
  });

  @override
  List<Object?> get props => [moves];

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }
}
