part of 'effect.dart';

class EffectUtils {
  static int maxHealth(GPlayer player) {
    return player.attributes.bullets ?? 0;
  }
}
