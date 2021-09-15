part of 'state.dart';

class GHit {
  final String name;
  final List<String> players;
  final List<String> abilities;
  final int cancelable;
  final List<String> targets;

  GHit({
    required this.name,
    required this.players,
    required this.abilities,
    required this.cancelable,
    required this.targets,
  });
}
