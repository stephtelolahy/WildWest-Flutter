part of 'state.dart';

class GCard {
  final String identifier;
  final String name;
  final CardType type;
  final String desc;
  final Map<CardAttributeKey, dynamic> attributes;
  final List<String> abilities;
  final String value;

  GCard(
      {this.identifier = '',
      this.name = '',
      this.type = CardType.none,
      this.desc = '',
      this.abilities = const [],
      this.attributes = const {},
      this.value = ''});
}

enum CardType {
  brown,
  blue,
  figure,
  none,
}

enum CardAttributeKey {
  bullets, // max health
  mustang, // increment distance from others
  scope, // decrement distance to others
  weapon, // gun range, default: 1
  flippedCards, // number of flipped cards on a draw, default: 1
  bangsCancelable, // number of 'missed' required to cancel your bang, default: 1
  bangsPerTurn, // number of bangs per turn, default: 1
  handLimit, // max number of cards at end of turn, default: health
  silentCard, // prevent other players to play a card matching given regex
  silentAbility, // disable self ability matching given name
  playAs, // can play card matching [regex] with ability [name]
  silentInPlay, // during your turn, cards in play in front of other players have no effect
}
