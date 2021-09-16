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
        priority = json['priority'] ?? 0;

  static List<PlayReq> _mapPlayReqs(Map<String, dynamic> source) {
    List<PlayReq> result = [];
    for (var key in source.keys) {
      result.add(PlayReq.map(key, source[key]));
    }
    return result;
  }

  static List<Effect> _mapEffects(List<dynamic> source) {
    return [];
  }
}

enum AbilityType {
  active,
  triggered,
}
