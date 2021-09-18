import 'package:equatable/equatable.dart';

import '../state/state.dart';

part 'activate.dart';
part 'cancel_hit.dart';
part 'deck_to_store.dart';
part 'discard_hand.dart';
part 'discard_in_play.dart';
part 'draw_deck.dart';
part 'draw_deck_choosing.dart';
part 'draw_deck_flipping.dart';
part 'draw_discard.dart';
part 'draw_hand.dart';
part 'draw_in_play.dart';
part 'draw_store.dart';
part 'eliminate.dart';
part 'equip.dart';
part 'flip_deck.dart';
part 'gain_health.dart';
part 'handicap.dart';
part 'idle.dart';
part 'loose_health.dart';
part 'pass_in_play.dart';
part 'play.dart';
part 'remove_hit.dart';
part 'set_hit.dart';
part 'set_phase.dart';
part 'set_turn.dart';
part 'set_winner.dart';

abstract class GEvent extends Equatable {
  GState dispatch(GState state);
  Duration duration();
}

const DEFAULT_EVENT_DURATION = Duration(milliseconds: 400);
