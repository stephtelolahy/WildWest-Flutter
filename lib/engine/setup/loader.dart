import 'dart:convert';

import 'package:flutter/services.dart';

import '../rules/ability.dart';
import '../state/state.dart';
import 'card_value.dart';

class ResLoader {
  Future<List<GCard>> loadCards() async {
    String data = await rootBundle.loadString('assets/json/bang_cards.json');
    List<dynamic> array = json.decode(data);
    return array.map((e) => GCard.fromJson(e)).toList();
  }

  Future<List<CardValue>> loadCardValues() async {
    String data = await rootBundle.loadString('assets/json/bang_card_values.json');
    List<dynamic> array = json.decode(data);
    return array.map((e) => CardValue.fromJson(e)).toList();
  }

  Future<List<Ability>> loadAbilities() async {
    String data = await rootBundle.loadString('assets/json/bang_abilities.json');
    List<dynamic> array = json.decode(data);
    return array.map((e) => Ability.fromJson(e)).toList();
  }
}
