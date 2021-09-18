import 'package:enum_to_string/enum_to_string.dart';

import '../state/state.dart';

class ResCard {
  final String name;
  final CardType type;
  final String desc;
  final CardAttributes attributes;
  final List<String> abilities;

  ResCard.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = EnumToString.fromString(CardType.values, json['type'])!,
        desc = json['desc'],
        attributes = CardAttributes.fromJson(json['attributes'] ?? {}),
        abilities = List<String>.from(json['abilities'] ?? []);
}
