import 'package:wildwest_flutter/engine/event/event.dart';
import 'package:wildwest_flutter/engine/resources/ability.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

class GRules {
  final List<ResAbility> abilities;

  GRules({required this.abilities});

  List<GMove> active(GState state) {
    return [];
  }

  List<GMove> triggered(GEvent event, GState state) {
    return [];
  }

  List<GEvent> effects(GMove move, GState state) {
    return [];
  }

  Role? isGameOver(GState state) {
    return null;
  }
}
