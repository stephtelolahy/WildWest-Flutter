import 'package:enum_to_string/enum_to_string.dart';

import '../state/state.dart';

class ResCard {
  final String name;
  final CardType type;
  final String desc;
  final CardAttributes attributes;

  ResCard.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = EnumToString.fromString(CardType.values, json['type'])!,
        desc = json['desc'],
        attributes = CardAttributes.fromJson(json['attributes'] ?? {});
}
