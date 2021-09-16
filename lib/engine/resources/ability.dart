import 'package:enum_to_string/enum_to_string.dart';

class ResAbility {
  final String name;
  final AbilityType type;
  final Map<String, dynamic> canPlay;
  final List<dynamic> onPlay;
  final int priority;

  ResAbility.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = EnumToString.fromString(AbilityType.values, json['type'])!,
        canPlay = json['canPlay'] ?? {},
        onPlay = json['onPlay'],
        priority = json['priority'] ?? 0;
}

enum AbilityType {
  active,
  triggered,
}
