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

    List<List<String>> combinedValues = values.toList().combineBy(amount);
    for (var arg in oldArgs) {
      combinedValues.forEach((e) => this.add(arg.copyWith(requiredHand: e)));
    }

    return this.isNotEmpty;
  }

  bool appendRequiredDeck(Iterable<String> values, int amount) {
    final oldArgs = List.from(this);
    if (oldArgs.isEmpty) oldArgs.add(PlayArgs());
    this.clear();

    List<List<String>> combinedValues = values.toList().combineBy(amount);
    for (var arg in oldArgs) {
      combinedValues.forEach((e) => this.add(arg.copyWith(requiredDeck: e)));
    }

    return this.isNotEmpty;
  }

  bool appendRequiredTargetCard(GState state) {
    final oldArgs = List.from(this);
    this.clear();

    for (var arg in oldArgs) {
      final target = arg.target;
      if (target == null) {
        return false;
      }

      final playerObject = state.player(identifier: target);
      List<String> cards = playerObject.inPlay.map((e) => e.identifier).toList();
      if (playerObject.hand.isNotEmpty) {
        cards.add('');
      }
      cards.forEach((e) => this.add(arg.copyWith(requiredTargetCard: e)));
    }

    return this.isNotEmpty;
  }
}

extension Combining<T> on List<T> {
  List<List<T>> combineBy(int size) {
    if (size == 0 || size > length) {
      return [];
    } else if (size == this.length) {
      return [this];
    } else if (size == 1) {
      return this.map((e) => [e]).toList();
    }

    final List<List<T>> result = [];
    for (var array in combineBy(size - 1)) {
      for (var element in this.where((e) => !array.contains(e))) {
        final elementIndex = this.indexOf(element);
        final lastArrayElement = array.last;
        final lastArrayIndex = this.indexOf(lastArrayElement);
        if (elementIndex > lastArrayIndex) {
          result.add(array + [element]);
        }
      }
    }

    return result;
  }
}
