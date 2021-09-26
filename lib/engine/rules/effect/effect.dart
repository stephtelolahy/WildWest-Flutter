import 'dart:math';

import 'package:enum_to_string/enum_to_string.dart';

import '../../event/event.dart';
import '../../list_extensions.dart';
import '../../state/state.dart';
import '../play_context.dart';
import '../state_extensions.dart';

part 'add_hit.dart';
part 'argument/card_argument.dart';
part 'argument/number_argument.dart';
part 'argument/player_argument.dart';
part 'deck_to_store.dart';
part 'discard.dart';
part 'draw_deck.dart';
part 'draw_deck_choosing.dart';
part 'draw_deck_flipping_if.dart';
part 'draw_discard.dart';
part 'draw_player.dart';
part 'draw_store.dart';
part 'equip.dart';
part 'flip_deck_if.dart';
part 'gain_health.dart';
part 'handicap.dart';
part 'loose_health.dart';
part 'pass_in_play.dart';
part 'remove_hit.dart';
part 'reverse_hit.dart';
part 'set_phase.dart';
part 'set_turn.dart';

abstract class Effect {
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

      case 'setTurn':
        return SetTurn.fromJson(json);

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

      case 'drawDeckChoosing':
        return DrawDeckChoosing.fromJson(json);

      case 'drawStore':
        return DrawStore.fromJson(json);

      case 'deckToStore':
        return DeckToStore.fromJson(json);

      case 'discard':
        return Discard.fromJson(json);

      case 'drawPlayer':
        return DrawPlayer.fromJson(json);

      case 'drawDiscard':
        return DrawDiscard.fromJson(json);

      case 'flipDeckIf':
        return FlipDeckIf.fromJson(json);

      case 'drawDeckFlippingIf':
        return DrawDeckFlippingIf.fromJson(json);

      case 'passInPlay':
        return PassInPlay.fromJson(json);

      default:
        throw Exception('Unknown effect: $key');
    }
  }

  static List<Effect> fromJsonArray(List<dynamic> array) {
    return array.map((e) => Effect.fromJson(e)).toList();
  }
}
