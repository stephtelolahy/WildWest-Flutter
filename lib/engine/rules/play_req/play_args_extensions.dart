part of 'play_req.dart';

extension Appending on List<PlayArgs> {
  bool appendTarget(Iterable<String> values) {
    final oldArgs = List.from(this);
    if (oldArgs.isEmpty) oldArgs.add(PlayArgs());
    this.clear();

    for (var arg in oldArgs) {
      values.forEach((e) => this.add(arg.copyWith(target: e)));
    }

    return this.isNotEmpty;
  }

  bool appendRequiredStore(Iterable<String> values) {
    final oldArgs = List.from(this);
    if (oldArgs.isEmpty) oldArgs.add(PlayArgs());
    this.clear();

    for (var arg in oldArgs) {
      values.forEach((e) => this.add(arg.copyWith(requiredStore: e)));
    }

    return this.isNotEmpty;
  }

  bool appendRequiredHand(Iterable<String> values, int amount) {
    final oldArgs = List.from(this);
    if (oldArgs.isEmpty) oldArgs.add(PlayArgs());
    this.clear();

    // TODO: combine cards
    for (var arg in oldArgs) {
      values.forEach((e) => this.add(arg.copyWith(requiredHand: [e])));
    }

    return this.isNotEmpty;
  }

  bool appendRequiredDeck(Iterable<String> values, int amount) {
    final oldArgs = List.from(this);
    if (oldArgs.isEmpty) oldArgs.add(PlayArgs());
    this.clear();

    // TODO: combine cards
    for (var arg in oldArgs) {
      values.forEach((e) => this.add(arg.copyWith(requiredDeck: [e])));
    }

    return this.isNotEmpty;
  }

  bool appendRequiredInPlay(GState state) {
    final oldArgs = List.from(this);
    this.clear();

    for (var arg in oldArgs) {
      final target = arg.target;
      if (target == null) {
        return false;
      }

      final playerObject = state.player(identifier: target);
      final cards = playerObject.inPlay.map((e) => e.identifier);
      cards.forEach((e) => this.add(arg.copyWith(requiredInPlay: e)));
    }

    return this.isNotEmpty;
  }
}
