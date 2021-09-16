part of 'state.dart';

class GHit {
  final String name;
  final List<String> players;
  final List<String> abilities;
  final int cancelable;
  final List<String> targets;

  GHit({
    this.name = '',
    this.players = const [],
    this.abilities = const [],
    this.cancelable = 0,
    this.targets = const [],
  });

  GHit.copy(GHit hit)
      : name = hit.name,
        players = hit.players,
        abilities = hit.abilities,
        cancelable = hit.cancelable,
        targets = hit.targets;
}
