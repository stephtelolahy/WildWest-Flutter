import 'package:enum_to_string/enum_to_string.dart';

import '../rules/effect/effect.dart';
import '../rules/play_req/play_req.dart';

class ResAbility {
  final String name;
  final AbilityType type;
  final List<PlayReq> canPlay;
  final List<Effect> onPlay;
  final int priority;

  ResAbility.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = EnumToString.fromString(AbilityType.values, json['type'])!,
        canPlay = _mapPlayReqs(json['canPlay'] ?? {}),
        onPlay = _mapEffects(json['onPlay']),
        priority = json['priority'] ?? 1;

  static List<PlayReq> _mapPlayReqs(Map<String, dynamic> source) {
    return source.keys.map((e) => PlayReq.fromKey(e, value: source[e])).toList();
  }

  static List<Effect> _mapEffects(List<dynamic> source) {
    return [];
  }
}

enum AbilityType {
  active,
  triggered,
}
