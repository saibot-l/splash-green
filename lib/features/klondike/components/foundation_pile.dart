import "dart:ui";

import "package:flame/components.dart";

import "../constants/dimensions.dart";
import "../models/pile.dart";
import "../models/suit.dart";
import "../paints/pile_paint.dart";
import "card.dart";

class FoundationPile extends PositionComponent with Pile {
  FoundationPile({
    required int suit,
    super.position,
  })  : suit = Suit.fromInt(suit),
        super(size: cardSize);

  final Suit suit;
  final List<Card> _cards = [];

  @override
  void acquireCard(Card card) {
    assert(card.isFaceUp);

    super.acquireCard(card);

    card
      ..position = position
      ..priority = _cards.length;

    _cards.add(card);
  }

  @override
  void removeCard(Card card) {
    assert(canMoveCard(card));
    _cards.removeLast();
  }

  @override
  void returnCard(Card card) {
    card
      ..position = position
      ..priority = _cards.indexOf(card);
  }

  @override
  bool canMoveCard(Card card) => _cards.isNotEmpty && card == _cards.last;

  @override
  bool canAcceptCard(Card card) {
    final topCardRank = _cards.isEmpty ? 0 : _cards.last.rank.value;
    return card.suit == suit &&
        card.rank.value == topCardRank + 1 &&
        card.attachedCards.isEmpty;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(cardRRect, PilePaint.border);
    suit.sprite.render(
      canvas,
      position: size / 2,
      anchor: Anchor.center,
      size: Vector2.all(kCardWidth * .6),
      overridePaint: PilePaint.suit,
    );
  }
}
