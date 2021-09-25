import 'dart:math';

import '../state/state.dart';

extension Distance on GState {
  int distance({required String from, required String to}) {
    final fromIndex = playOrder.indexOf(from);
    final toIndex = playOrder.indexOf(to);
    if (fromIndex == toIndex) {
      return 0;
    }

    final count = playOrder.length;
    final rightDistance =
        (toIndex > fromIndex) ? (toIndex - fromIndex) : (toIndex + count - fromIndex);
    final leftDistance =
        (fromIndex > toIndex) ? (fromIndex - toIndex) : (fromIndex + count - toIndex);
    var distance = min(rightDistance, leftDistance);

    distance -= player(identifier: from).currentScope();

    distance += player(identifier: to).currentMustang();

    return distance;
  }
}

extension Attributes on GPlayer {
  int currentWeapon() {
    final cards = inPlay + [this];
    return cards.map((e) => e.weapon ?? 1).reduce(max);
  }

  int currentScope() {
    final cards = inPlay + [this];
    return cards.map((e) => e.scope ?? 0).reduce((a, b) => a + b);
  }

  int currentMustang() {
    final cards = inPlay + [this];
    return cards.map((e) => e.mustang ?? 0).reduce((a, b) => a + b);
  }

  int currentBangsPerTurn() {
    final cards = inPlay + [this];
    final values = cards.map((e) => e.bangsPerTurn).whereType<int>();
    if (values.isNotEmpty) {
      return values.reduce(max);
    } else {
      return 1;
    }
  }

  int maxHand() {
    return handLimit ?? health;
  }

  int maxHealth() {
    return bullets ?? 0;
  }
}

extension RegexMatching on GCard {
  bool matchesRegex(String regex) {
    return RegExp(regex).hasMatch('$name$value');
  }
}
