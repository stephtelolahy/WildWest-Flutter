import '../../event/event.dart';
import '../play_context.dart';

abstract class Effect {
  List<GEvent> apply(PlayContext ctx);
}
