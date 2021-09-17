part of 'state.dart';

class GCard {
  final String identifier;
  final String name;
  final CardType type;
  final String desc;
  final CardAttributes attributes;
  final String value;

  GCard(
      {this.identifier = '',
      this.name = '',
      this.type = CardType.none,
      this.desc = '',
      this.attributes = const CardAttributes(),
      this.value = ''});
}

enum CardType {
  brown,
  blue,
  figure,
  none,
}

class CardAttributes {
  final int? bullets; // max health
  final int? mustang; // increment distance from others
  final int? scope; // decrement distance to others
  final int? weapon; // gun range, default: 1
  final int? flippedCards; // number of flipped cards on a draw, default: 1
  final int? bangsCancelable; // number of 'missed' required to cancel your bang, default: 1
  final int? bangsPerTurn; // number of bangs per turn, default: 1
  final int? handLimit; // max number of cards at end of turn, default: health
  final String? silentCard; // prevent other players to play a card matching given regex
  final String? silentAbility; // disable self ability matching given name
  final Map<String, dynamic> playAs; // can play card matching [regex] with ability [name]
  final bool
      silentInPlay; // during your turn, cards in play in front of other players have no effect
  final List<String> abilities;

  const CardAttributes({
    this.bullets,
    this.mustang,
    this.scope,
    this.weapon,
    this.flippedCards,
    this.bangsCancelable,
    this.bangsPerTurn,
    this.handLimit,
    this.silentCard,
    this.silentAbility,
    this.playAs = const {},
    this.silentInPlay = false,
    this.abilities = const [],
  });

  CardAttributes.fromJson(Map<String, dynamic> json)
      : bullets = json['bullets'],
        mustang = json['mustang'],
        scope = json['scope'],
        weapon = json['weapon'],
        flippedCards = json['flippedCards'],
        bangsCancelable = json['bangsCancelable'],
        bangsPerTurn = json['bangsPerTurn'],
        handLimit = json['handLimit'],
        silentCard = json['silentCard'],
        silentAbility = json['silentAbility'],
        playAs = json['playAs'] ?? {},
        silentInPlay = json['silentInPlay'] ?? false,
        abilities = json['abilities'] ?? [];
}
