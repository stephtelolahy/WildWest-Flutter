import '../event/event.dart';
import '../state/state.dart';

class PlayContext {
  final String ability;
  final GPlayer actor;
  final GState state;
  final String? handCard;
  final String? inPlayCard;
  final GEvent? event;
  final PlayArgs args;

  PlayContext({
    required this.ability,
    required this.actor,
    required this.state,
    this.handCard,
    this.inPlayCard,
    this.event,
    this.args = const PlayArgs(),
  });
}
