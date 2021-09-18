import '../../state/state.dart';
import 'dart:math';

class PlayReqUtils {
  static bool appendTarget(Iterable<String> values, List<PlayArgs> args) {
    final oldArgs = List.from(args);
    if (oldArgs.isEmpty) oldArgs.add(PlayArgs());
    args.clear();

    for (var arg in oldArgs) {
      values.forEach((e) => args.add(arg.copyWith(target: e)));
    }

    return args.isNotEmpty;
  }

  static bool appendRequiredStore(Iterable<String> values, List<PlayArgs> args) {
    final oldArgs = List.from(args);
    if (oldArgs.isEmpty) oldArgs.add(PlayArgs());
    args.clear();

    for (var arg in oldArgs) {
      values.forEach((e) => args.add(arg.copyWith(requiredStore: e)));
    }

    return args.isNotEmpty;
  }

  static bool appendRequiredHand(Iterable<String> values, int amount, List<PlayArgs> args) {
    final oldArgs = List.from(args);
    if (oldArgs.isEmpty) oldArgs.add(PlayArgs());
    args.clear();

// TODO: perform combination algorithm
    for (var arg in oldArgs) {
      values.forEach((e) => args.add(arg.copyWith(requiredHand: [e])));
    }

    return args.isNotEmpty;
  }

  static bool appendRequiredDeck(Iterable<String> values, int amount, List<PlayArgs> args) {
    final oldArgs = List.from(args);
    if (oldArgs.isEmpty) oldArgs.add(PlayArgs());
    args.clear();

// TODO: perform combination algorithm
    for (var arg in oldArgs) {
      values.forEach((e) => args.add(arg.copyWith(requiredDeck: [e])));
    }

    return args.isNotEmpty;
  }

  static bool appendRequiredInPlay(GState state, List<PlayArgs> args) {
    final oldArgs = List.from(args);
    args.clear();

    for (var arg in oldArgs) {
      final target = arg.target;
      if (target == null) {
        return false;
      }

      final playerObject = state.player(identifier: target);
      final cards = playerObject.inPlay.map((e) => e.identifier);
      cards.forEach((e) => args.add(arg.copyWith(requiredInPlay: e)));
    }

    return args.isNotEmpty;
  }

  static int distance({required String from, required String to, required GState state}) {
    final fromIndex = state.playOrder.indexOf(from);
    final toIndex = state.playOrder.indexOf(to);
    if (fromIndex == toIndex) {
      return 0;
    }

    final count = state.playOrder.length;
    final rightDistance =
        (toIndex > fromIndex) ? (toIndex - fromIndex) : (toIndex + count - fromIndex);
    final leftDistance =
        (fromIndex > toIndex) ? (fromIndex - toIndex) : (fromIndex + count - toIndex);
    var distance = min(rightDistance, leftDistance);

    distance -= scope(state.player(identifier: from));

    distance += mustang(state.player(identifier: to));

    return distance;
  }

  static int weapon(GPlayer player) {
    return player.inPlay.map((e) => e.attributes.weapon ?? 1).reduce(max);
  }

  static int scope(GPlayer player) {
    final cards = player.inPlay + [player];
    return cards.map((e) => e.attributes.scope ?? 0).reduce((a, b) => a + b);
  }

  static int mustang(GPlayer player) {
    final cards = player.inPlay + [player];
    return cards.map((e) => e.attributes.mustang ?? 0).reduce((a, b) => a + b);
  }

  static int bangsPerTurn(GPlayer player) {
    final cards = player.inPlay + [player];
    final values = cards.map((e) => e.attributes.bangsPerTurn).whereType<int>();
    if (values.isNotEmpty) {
      return values.reduce(max);
    } else {
      return 1;
    }
  }

  static int handLimit(GPlayer player) {
    return player.attributes.handLimit ?? player.health;
  }
}
