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

    distance -= player(identifier: from).scope();

    distance += player(identifier: to).mustang();

    return distance;
  }
}

extension Attributes on GPlayer {
  int weapon() {
    final cards = inPlay + [this];
    return cards.map((e) => e.attributes.weapon ?? 1).reduce(max);
  }

  int scope() {
    final cards = inPlay + [this];
    return cards.map((e) => e.attributes.scope ?? 0).reduce((a, b) => a + b);
  }

  int mustang() {
    final cards = inPlay + [this];
    return cards.map((e) => e.attributes.mustang ?? 0).reduce((a, b) => a + b);
  }

  int bangsPerTurn() {
    final cards = inPlay + [this];
    final values = cards.map((e) => e.attributes.bangsPerTurn).whereType<int>();
    if (values.isNotEmpty) {
      return values.reduce(max);
    } else {
      return 1;
    }
  }

  int handLimit() {
    return attributes.handLimit ?? health;
  }

  int maxHealth() {
    return attributes.bullets ?? 0;
  }
}
