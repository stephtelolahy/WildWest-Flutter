import '../event/event.dart';
import '../state/state.dart';

class PlayContext {
  final String ability;
  final GPlayer actor;
  final GState state;
  final GCard? card;
  final GEvent? event;
  final Map<PlayArg, dynamic> args;

  PlayContext({
    required this.ability,
    required this.actor,
    required this.state,
    this.card,
    this.event,
    this.args = const {},
  });
}
