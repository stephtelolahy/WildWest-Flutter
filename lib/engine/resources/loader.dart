import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:wildwest_flutter/engine/resources/ability.dart';
import 'package:wildwest_flutter/engine/resources/card.dart';
import 'package:wildwest_flutter/engine/resources/card_value.dart';

class ResLoader {
  Future<List<ResCard>> loadCards() async {
    String data = await rootBundle.loadString('assets/json/bang_cards.json');
    List<dynamic> array = json.decode(data);
    return array.map((e) => ResCard.fromJson(e)).toList();
  }

  Future<List<ResCardValue>> loadCardValues() async {
    String data = await rootBundle.loadString('assets/json/bang_card_values.json');
    List<dynamic> array = json.decode(data);
    return array.map((e) => ResCardValue.fromJson(e)).toList();
  }

  Future<List<ResAbility>> loadAbilities() async {
    String data = await rootBundle.loadString('assets/json/bang_abilities.json');
    List<dynamic> array = json.decode(data);
    return array.map((e) => ResAbility.fromJson(e)).toList();
  }
}
