import 'package:wildwest_flutter/engine/state/state.dart';

import '../play_context.dart';
part 'is_your_turn.dart';
part 'is_phase.dart';
part 'require_target_other.dart';
part 'is_players_count_min.dart';
part 'is_hit_effect.dart';
part 'is_health.dart';

abstract class PlayReq {
  bool match(PlayContext ctx, List<Map<PlayArg, dynamic>> args);

  static PlayReq map(String key, dynamic value) {
    switch (key) {
      case 'isYourTurn':
        return IsYourTurn();

      case 'isPhase':
        return IsPhase(phase: value as int);

      case 'isPlayersCountMin':
        return IsPlayersCountMin(minPlayersCount: value as int);

      case 'requireTargetOther':
        return RequireTargetOther();

      case 'isHitEffect':
        return IsHitEffect(ability: value as String);

      case 'isHealth':
        return IsHealth(health: value as int);

      default:
        throw Exception('Unknown playReq: $key');
    }
  }
}
