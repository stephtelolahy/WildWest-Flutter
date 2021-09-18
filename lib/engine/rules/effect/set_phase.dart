part of 'effect.dart';

/*
 Set phase X
 */
class SetPhase extends Effect {
  final int phase;

  SetPhase.fromJson(Map<String, dynamic> json) : phase = json['value'];

  @override
  List<GEvent> apply(PlayContext ctx) {
    return [GEventSetPhase(phase: phase)];
  }
}
