import 'package:wildwest_flutter/engine/rules/play_req/play_req_utils.dart';
import 'package:wildwest_flutter/engine/state/state.dart';

import '../play_context.dart';
part 'is_your_turn.dart';
part 'is_phase.dart';
part 'is_players_count_min.dart';
part 'is_times_per_turn_max.dart';
part 'is_times_per_turn_max_bangs_per_turn.dart';
part 'is_hit_effect.dart';
part 'is_health.dart';
part 'require_target_other.dart';
part 'require_target_any.dart';
part 'require_target_at.dart';
part 'require_target_reachable.dart';
part 'require_inplay_card.dart';

abstract class PlayReq {
  bool match(PlayContext ctx, List<PlayArgs> args);

  static PlayReq map(String key, dynamic value) {
    switch (key) {
      case 'isYourTurn':
        return IsYourTurn();

      case 'isPhase':
        return IsPhase(phase: value as int);

      case 'isPlayersCountMin':
        return IsPlayersCountMin(minPlayersCount: value as int);

      case 'isHitEffect':
        return IsHitEffect(ability: value as String);

      case 'isHealth':
        return IsHealth(health: value as int);

      case 'isTimesPerTurnMax':
        return IsTimesPerTurnMax(maxTimes: value as int);

      case 'isTimesPerTurnMaxBangsPerTurn':
        return IsTimesPerTurnMaxBangsPerTurn();

      case 'requireTargetOther':
        return RequireTargetOther();

      case 'requireTargetAny':
        return RequireTargetAny();

      case 'requireTargetAt':
        return RequireTargetAt(distance: value as int);

      case 'requireTargetReachable':
        return RequireTargetReachable();

      case 'requireInPlayCard':
        return RequireInPlayCard();

      default:
        throw Exception('Unknown playReq: $key');
    }
  }
}
