import "dart:ui";

import "package:flame/components.dart";

import "../constants/dimensions.dart";
import "../models/pile.dart";
import "../paints/pile_paint.dart";
import "card.dart";

class TableauPile extends PositionComponent with Pile {
  TableauPile({super.position}) : super(size: cardSize);

  final List<Card> _cards = [];
  final Vector2 _fanOffsetFaceDown = Vector2(0, kCardHeight * .075);
  final Vector2 _fanOffsetFaceUp = Vector2(0, kCardHeight * .25);

  void flipTopCard() {
    assert(_cards.last.isFaceDown);
    _cards.last.flip();
  }

  List<Card> getCardsOnTo(Card card) {
    assert(card.isFaceUp && _cards.contains(card));

    return _cards.getRange(_cards.indexOf(card) + 1, _cards.length).toList();
  }

  @override
  void acquireCard(Card card) {
    super.acquireCard(card);

    card
      ..position =
          _cards.isEmpty ? position : _cards.last.position + _fanOffsetFaceDown
      ..priority = _cards.length;
    _cards.add(card);

    layOutCards();
  }

  @override
  void removeCard(Card card) {
    assert(_cards.contains(card) && card.isFaceUp);

    final index = _cards.indexOf(card);
    _cards.removeRange(index, _cards.length);

    if (_cards.isNotEmpty && _cards.last.isFaceDown) {
      flipTopCard();
    }

    layOutCards();
  }

  @override
  void returnCard(Card card) {
    final index = _cards.indexOf(card);
    card
      ..position = index == 0
          ? position
          : _cards[index - 1].position + _fanOffsetFaceDown
      ..priority = index;

    layOutCards();
  }

  @override
  bool canMoveCard(Card card) => card.isFaceUp;

  @override
  bool canAcceptCard(Card card) {
    if (_cards.isEmpty) return card.rank.value == 13;

    final topCard = _cards.last;
    return card.suit.isRed == !topCard.suit.isRed &&
        card.rank.value == topCard.rank.value - 1;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(cardRRect, PilePaint.border);
  }

  void layOutCards() {
    if (_cards.isEmpty) return;

    _cards[0].position.setFrom(position);
    for (int i = 1; i < _cards.length; i++) {
      _cards[i].position
        ..setFrom(_cards[i - 1].position)
        ..add(_cards[i - 1].isFaceDown ? _fanOffsetFaceDown : _fanOffsetFaceUp);
    }

    height = kCardHeight * 1.5 + _cards.last.y - _cards.first.y;
  }
}
