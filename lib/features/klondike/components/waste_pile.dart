import "package:flame/components.dart";

import "../constants/dimensions.dart";
import "../klondike.dart";
import "../models/pile.dart";
import "card.dart";

class WastePile extends PositionComponent with HasGameRef<Klondike>, Pile {
  WastePile({super.position}) : super(size: cardSize);

  final List<Card> _cards = [];

  @override
  void acquireCard(Card card) {
    assert(card.isFaceUp);

    super.acquireCard(card);

    card
      ..position = position
      ..priority = _cards.length;

    _cards.add(card);

    _fanOutTopCards();
  }

  @override
  void removeCard(Card card) {
    assert(canMoveCard(card));
    _cards.removeLast();
    _fanOutTopCards();
  }

  @override
  void returnCard(Card card) {
    card.priority = _cards.indexOf(card);
    _fanOutTopCards();
  }

  List<Card> removeAllCards() {
    final cards = _cards.toList();
    _cards.clear();
    return cards;
  }

  @override
  bool canMoveCard(Card card) => _cards.isNotEmpty && card == _cards.last;

  @override
  bool canAcceptCard(Card card) => false;

  static get _fanOffset => Vector2(kCardWidth * 0.2, 0);

  void _fanOutTopCards() {
    if (game.klondikeDraw == 1) return;

    final numberOfCards = _cards.length;

    for (final card in _cards) {
      card.position = position;
    }

    if (numberOfCards == 2) {
      _cards[1].position.add(_fanOffset);
    } else if (numberOfCards >= 3) {
      _cards[numberOfCards - 2].position.add(_fanOffset);
      _cards[numberOfCards - 1].position.addScaled(_fanOffset, 2);
    }
  }
}
