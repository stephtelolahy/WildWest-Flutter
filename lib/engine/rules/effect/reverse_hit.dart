part of 'effect.dart';

class ReverseHit extends Effect {
  ReverseHit.fromJson(Map<String, dynamic> json);

  @override
  List<GEvent> apply(PlayContext ctx) {
    return [GEventReverseHit()];
  }
}
