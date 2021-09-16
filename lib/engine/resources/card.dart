import 'package:enum_to_string/enum_to_string.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

class ResCard {
  final String name;
  final CardType type;
  final String desc;
  final Map<CardAttributeKey, dynamic> attributes;
  final List<String> abilities;

  ResCard.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = EnumToString.fromString(CardType.values, json['type'])!,
        desc = json['desc'],
        attributes = _mapAttributes(json['attributes'] ?? {}),
        abilities = List<String>.from(json['abilities'] ?? []);

  static Map<CardAttributeKey, dynamic> _mapAttributes(Map<String, dynamic> source) {
    Map<CardAttributeKey, dynamic> result = {};
    for (var key in source.keys) {
      final attribute = EnumToString.fromString(CardAttributeKey.values, key)!;
      result[attribute] = source[key];
    }
    return result;
  }
}
