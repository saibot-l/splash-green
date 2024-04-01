import "dart:ui";

import "package:flame/components.dart";
import "package:flame/events.dart";

import "../constants/dimensions.dart";
import "../klondike.dart";
import "../models/pile.dart";
import "../paints/pile_paint.dart";
import "card.dart";
import "waste_pile.dart";

class StockPile extends PositionComponent
    with HasGameRef<Klondike>, Pile, TapCallbacks {
  StockPile({super.position}) : super(size: cardSize);

  final List<Card> _cards = [];

  @override
  void acquireCard(Card card) {
    assert(card.isFaceDown);

    super.acquireCard(card);

    card
      ..position = position
      ..priority = _cards.length;

    _cards.add(card);
  }

  @override
  void removeCard(Card card) =>
      throw StateError("Cannot remove cards from stock pile.");

  @override
  void returnCard(Card card) =>
      throw StateError("Cannot return cards to stock pile.");

  @override
  bool canMoveCard(Card card) => false;

  @override
  bool canAcceptCard(Card card) => false;

  @override
  void onTapUp(TapUpEvent event) {
    final wastePile = parent?.firstChild<WastePile>();
    if (wastePile == null) return;

    if (_cards.isEmpty) {
      wastePile.removeAllCards().reversed.forEach((card) {
        card.flip();
        acquireCard(card);
      });
    } else {
      for (int i = 0; i < game.klondikeDraw; i++) {
        if (_cards.isEmpty) break;

        final card = _cards.removeLast()..flip();
        wastePile.acquireCard(card);
      }
    }
  }

  @override
  void render(Canvas canvas) {
    canvas
      ..drawRRect(cardRRect, PilePaint.emptyBorder)
      ..drawCircle(
        Offset(width / 2, height / 2),
        kCardWidth * .3,
        PilePaint.emptyCircle,
      );
  }
}
