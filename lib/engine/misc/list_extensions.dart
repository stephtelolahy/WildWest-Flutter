import 'dart:math';

extension Convenience<T> on List<T> {
  T randomElement() {
    final random = new Random();
    var i = random.nextInt(this.length);
    return this[i];
  }

  List<T> startingWith(T element) {
    final index = this.indexOf(element);
    return this.sublist(index)..addAll(this.sublist(0, index));
  }

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
