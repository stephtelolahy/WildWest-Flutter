import 'package:enum_to_string/enum_to_string.dart';

import 'effect/effect.dart';
import 'play_req/play_req.dart';

class Ability {
  final String name;
  final AbilityType type;
  final List<PlayReq> canPlay;
  final List<Effect> onPlay;
  final int priority;

  Ability.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = EnumToString.fromString(AbilityType.values, json['type'])!,
        canPlay = _mapPlayReqs(json['canPlay'] ?? {}),
        onPlay = _mapEffects(json['onPlay']),
        priority = json['priority'] ?? 1;

  static List<PlayReq> _mapPlayReqs(Map<String, dynamic> source) {
    return source.keys.map((e) => PlayReq.fromKey(e, value: source[e])).toList();
  }

  static List<Effect> _mapEffects(List<dynamic> source) {
    return source.map((e) => Effect.fromJson(e)).toList();
  }
}

enum AbilityType {
  active,
  triggered,
}
