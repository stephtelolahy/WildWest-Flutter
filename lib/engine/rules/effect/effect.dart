import 'dart:math';

import 'package:enum_to_string/enum_to_string.dart';

import '../../event/event.dart';
import '../../state/state.dart';
import '../play_context.dart';
import '../state_extensions.dart';

part 'add_hit.dart';
part 'argument/card_argument.dart';
part 'argument/number_argument.dart';
part 'argument/player_argument.dart';
part 'draw_deck.dart';
part 'equip.dart';
part 'gain_health.dart';
part 'handicap.dart';
part 'loose_health.dart';
part 'remove_hit.dart';
part 'reverse_hit.dart';
part 'set_phase.dart';
part 'deck_to_store.dart';

abstract class Effect {
  // TODO: parse optional
  final bool optional = false;

  List<GEvent> apply(PlayContext ctx);

  static Effect fromJson(Map<String, dynamic> json) {
    final key = json['action'] as String;
    switch (key) {
      case 'equip':
        return Equip.fromJson(json);

      case 'handicap':
        return Handicap.fromJson(json);

      case 'setPhase':
        return SetPhase.fromJson(json);

      case 'gainHealth':
        return GainHealth.fromJson(json);

      case 'addHit':
        return AddHit.fromJson(json);

      case 'removeHit':
        return RemoveHit.fromJson(json);

      case 'reverseHit':
        return ReverseHit.fromJson(json);

      case 'looseHealth':
        return LooseHealth.fromJson(json);

      case 'drawDeck':
        return DrawDeck.fromJson(json);

      case 'deckToStore':
        return DeckToStore.fromJson(json);

      default:
        print('Unknown effect: $key');
        return DummyEffect();
      // throw Exception('Unknown effect: $key');
    }
  }
}

class DummyEffect extends Effect {
  @override
  List<GEvent> apply(PlayContext ctx) => [];
}
