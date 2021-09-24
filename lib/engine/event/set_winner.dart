part of 'event.dart';

class GEventSetWinner extends GEvent {
  final Role winner;

  @override
  List<Object?> get props => [winner];

  GEventSetWinner({
    required this.winner,
  });

  @override
  GState dispatch(GState state) {
    throw UnimplementedError();
  }
}
