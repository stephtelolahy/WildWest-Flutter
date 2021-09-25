part of 'state.dart';

class GCard extends Equatable {
  final String id;
  final String name;
  final CardType type;
  final String desc;
  final String value; // suit and value
  final List<String> abilities; // effects when played
  final int? bullets; // max health
  final int? mustang; // increment distance from others
  final int? scope; // decrement distance to others
  final int? weapon; // gun range, default: 1
  final int? flippedCards; // number of flipped cards on a draw, default: 1
  final int? bangsPerTurn; // number of bangs per turn, default: 1
  final int? handLimit; // max number of cards at end of turn, default: health
  final String? silentCard; // prevent other players to play a card matching given regex
  final String? silentAbility; // disable self ability matching given name
  final Map<String, dynamic>? playAs; // can play card matching [regex] with ability [name]

  GCard({
    this.id = '',
    this.name = '',
    this.type = CardType.none,
    this.desc = '',
    this.value = '',
    this.abilities = const [],
    this.bullets,
    this.mustang,
    this.scope,
    this.weapon,
    this.flippedCards,
    this.bangsPerTurn,
    this.handLimit,
    this.silentCard,
    this.silentAbility,
    this.playAs,
  });

  GCard.fromJson(Map<String, dynamic> json)
      : id = '',
        name = json['name'],
        type = EnumToString.fromString(CardType.values, json['type'])!,
        desc = json['desc'],
        value = '',
        abilities = List<String>.from(json['abilities'] ?? []),
        bullets = json['bullets'],
        mustang = json['mustang'],
        scope = json['scope'],
        weapon = json['weapon'],
        flippedCards = json['flippedCards'],
        bangsPerTurn = json['bangsPerTurn'],
        handLimit = json['handLimit'],
        silentCard = json['silentCard'],
        silentAbility = json['silentAbility'],
        playAs = json['playAs'];

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        desc,
        value,
        abilities,
        bullets,
        mustang,
        scope,
        weapon,
        flippedCards,
        bangsPerTurn,
        handLimit,
        silentCard,
        silentAbility,
        playAs,
      ];
}

enum CardType {
  brown,
  blue,
  figure,
  none,
}
