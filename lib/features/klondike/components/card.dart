import "dart:math";

import "package:flame/components.dart";
import "package:flame/effects.dart";
import "package:flame/events.dart";
import "package:flutter/material.dart";

import "../constants/dimensions.dart";
import "../models/pile.dart";
import "../models/rank.dart";
import "../models/suit.dart";
import "../paints/card_back_paint.dart";
import "../paints/card_color_filter.dart";
import "../paints/card_front_paint.dart";
import "../utils/klondike_sprite.dart";
import "tableau_pile.dart";

class Card extends PositionComponent with DragCallbacks {
  Card({
    required int rank,
    required int suit,
  })  : rank = Rank.fromInt(rank),
        suit = Suit.fromInt(suit),
        _faceUp = false,
        super(
          size: cardSize,
        );

  final Rank rank;
  final Suit suit;

  final List<Card> attachedCards = [];

  Pile? pile;
  bool _faceUp;

  bool get isFaceUp => _faceUp;
  bool get isFaceDown => !_faceUp;
  void flip() => _faceUp = !_faceUp;

  Vector2 _whereCardStarted = Vector2(0, 0);

  bool canMoveCard() => pile?.canMoveCard(this) ?? false;

  @override
  void onDragStart(DragStartEvent event) {
    if (!canMoveCard()) return;

    super.onDragStart(event);

    _whereCardStarted = Vector2(position.x, position.y);
    priority = 100;

    final tableauPile = pile is TableauPile ? pile as TableauPile : null;
    if (tableauPile != null) {
      attachedCards.clear();
      final extraCards = tableauPile.getCardsOnTo(this);
      for (final card in extraCards) {
        card.priority = attachedCards.length + 101;
        attachedCards.add(card);
      }
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (!isDragged) return;

    super.onDragUpdate(event);

    final delta = event.localDelta;
    position += delta;
    for (final card in attachedCards) {
      card.position.add(delta);
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (!isDragged) return;

    super.onDragEnd(event);
    final dropPile = parent
        ?.componentsAtPoint(position + size / 2)
        .whereType<Pile>()
        .firstOrNull;

    if (dropPile != null && dropPile.canAcceptCard(this)) {
      passCardTo(dropPile);
    } else {
      returnCard();
    }
  }

  void passCardTo(Pile dropPile) {
    pile?.removeCard(this);
    dropPile.acquireCard(this);

    if (attachedCards.isEmpty) return;
    for (final card in attachedCards) {
      dropPile.acquireCard(card);
    }
    attachedCards.clear();
  }

  void returnCard() {
    doMove(
      _whereCardStarted,
      onComplete: () {
        pile?.returnCard(this);
      },
    );

    if (attachedCards.isEmpty) return;
    for (final card in attachedCards) {
      final offset = card.position - position;
      card.doMove(
        _whereCardStarted + offset,
        onComplete: () {
          pile?.returnCard(card);
        },
      );
    }
    attachedCards.clear();
  }

  void doMove(
    Vector2 to, {
    double speed = 20,
    double start = 0,
    Curve curve = Curves.easeOutQuad,
    VoidCallback? onComplete,
  }) async {
    assert(speed > 0.0, "Speed must be > 0.");
    final dt = (to - position).length / (speed * size.x);
    assert(dt > 0.0, "Distance to move must be > 0.");
    priority = 100;
    await add(
      MoveToEffect(
        to,
        EffectController(
          duration: dt,
          startDelay: start,
          curve: curve,
        ),
        onComplete: onComplete,
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    if (_faceUp) {
      _renderFront(canvas);
    } else {
      _renderBack(canvas);
    }
  }

  static final Sprite flameSprite = klondikeSprite(
    position: Vector2(1367, 6),
    size: Vector2(357, 501),
  );

  void _renderBack(Canvas canvas) {
    canvas
      ..drawRRect(cardRRect, CardBackPaint.background)
      ..drawRRect(cardRRect, CardBackPaint.border);
    flameSprite.render(
      canvas,
      position: size / 2,
      anchor: Anchor.center,
    );
  }

  static final Sprite redJack =
      klondikeSprite(position: Vector2(81, 565), size: Vector2(562, 488))
        ..paint = CardColorFilter.red;
  static final Sprite redQueen =
      klondikeSprite(position: Vector2(717, 541), size: Vector2(486, 515))
        ..paint = CardColorFilter.red;
  static final Sprite redKing =
      klondikeSprite(position: Vector2(1305, 532), size: Vector2(407, 549))
        ..paint = CardColorFilter.red;

  static final Sprite blackJack =
      klondikeSprite(position: Vector2(81, 565), size: Vector2(562, 488))
        ..paint = CardColorFilter.black;
  static final Sprite blackQueen =
      klondikeSprite(position: Vector2(717, 541), size: Vector2(486, 515))
        ..paint = CardColorFilter.black;
  static final Sprite blackKing =
      klondikeSprite(position: Vector2(1305, 532), size: Vector2(407, 549))
        ..paint = CardColorFilter.black;

  void _renderFront(Canvas canvas) {
    final rankSprite = suit.isRed ? rank.redSprite : rank.blackSprite;
    final suitSprite = suit.sprite;

    canvas
      ..drawRRect(cardRRect, CardFrontPaint.background)
      ..drawRRect(
        cardRRect,
        suit.isRed ? CardFrontPaint.redBorder : CardFrontPaint.blackBorder,
      );
    _drawSprite(canvas, rankSprite, Vector2(.1, .08));
    _drawSprite(canvas, rankSprite, Vector2(.1, .08), rotate: true);
    _drawSprite(canvas, suitSprite, Vector2(.1, .18), scale: 0.5);
    _drawSprite(canvas, suitSprite, Vector2(.1, .18), scale: 0.5, rotate: true);

    switch (rank.value) {
      case 1:
        _drawSprite(canvas, suitSprite, Vector2(.5, .5), scale: 2.5);
      case 2:
        _drawSprite(canvas, suitSprite, Vector2(.5, .25));
        _drawSprite(canvas, suitSprite, Vector2(.5, .25), rotate: true);
      case 3:
        _drawSprite(canvas, suitSprite, Vector2(.5, .2));
        _drawSprite(canvas, suitSprite, Vector2(.5, .5));
        _drawSprite(canvas, suitSprite, Vector2(.5, .2), rotate: true);
      case 4:
        _drawSprite(canvas, suitSprite, Vector2(.3, .25));
        _drawSprite(canvas, suitSprite, Vector2(.7, .25));
        _drawSprite(canvas, suitSprite, Vector2(.3, .25), rotate: true);
        _drawSprite(canvas, suitSprite, Vector2(.7, .25), rotate: true);
      case 5:
        _drawSprite(canvas, suitSprite, Vector2(.3, .25));
        _drawSprite(canvas, suitSprite, Vector2(.7, .25));
        _drawSprite(canvas, suitSprite, Vector2(.3, .25), rotate: true);
        _drawSprite(canvas, suitSprite, Vector2(.7, .25), rotate: true);
        _drawSprite(canvas, suitSprite, Vector2(.5, .5));
      case 6:
        _drawSprite(canvas, suitSprite, Vector2(.3, .25));
        _drawSprite(canvas, suitSprite, Vector2(.7, .25));
        _drawSprite(canvas, suitSprite, Vector2(.3, .5));
        _drawSprite(canvas, suitSprite, Vector2(.7, .5));
        _drawSprite(canvas, suitSprite, Vector2(.3, .25), rotate: true);
        _drawSprite(canvas, suitSprite, Vector2(.7, .25), rotate: true);
      case 7:
        _drawSprite(canvas, suitSprite, Vector2(.3, .2));
        _drawSprite(canvas, suitSprite, Vector2(.7, .2));
        _drawSprite(canvas, suitSprite, Vector2(.5, .35));
        _drawSprite(canvas, suitSprite, Vector2(.3, .5));
        _drawSprite(canvas, suitSprite, Vector2(.7, .5));
        _drawSprite(canvas, suitSprite, Vector2(.3, .2), rotate: true);
        _drawSprite(canvas, suitSprite, Vector2(.7, .2), rotate: true);
      case 8:
        _drawSprite(canvas, suitSprite, Vector2(.3, .2));
        _drawSprite(canvas, suitSprite, Vector2(.7, .2));
        _drawSprite(canvas, suitSprite, Vector2(.5, .35));
        _drawSprite(canvas, suitSprite, Vector2(.3, .5));
        _drawSprite(canvas, suitSprite, Vector2(.7, .5));
        _drawSprite(canvas, suitSprite, Vector2(.3, .2), rotate: true);
        _drawSprite(canvas, suitSprite, Vector2(.7, .2), rotate: true);
        _drawSprite(canvas, suitSprite, Vector2(.5, .35), rotate: true);
      case 9:
        _drawSprite(canvas, suitSprite, Vector2(.3, .2));
        _drawSprite(canvas, suitSprite, Vector2(.7, .2));
        _drawSprite(canvas, suitSprite, Vector2(.5, .3));
        _drawSprite(canvas, suitSprite, Vector2(.3, .4));
        _drawSprite(canvas, suitSprite, Vector2(.7, .4));
        _drawSprite(canvas, suitSprite, Vector2(.3, .2), rotate: true);
        _drawSprite(canvas, suitSprite, Vector2(.7, .2), rotate: true);
        _drawSprite(canvas, suitSprite, Vector2(.3, .4), rotate: true);
        _drawSprite(canvas, suitSprite, Vector2(.7, .4), rotate: true);
      case 10:
        _drawSprite(canvas, suitSprite, Vector2(.3, .2));
        _drawSprite(canvas, suitSprite, Vector2(.7, .2));
        _drawSprite(canvas, suitSprite, Vector2(.5, .3));
        _drawSprite(canvas, suitSprite, Vector2(.3, .4));
        _drawSprite(canvas, suitSprite, Vector2(.7, .4));
        _drawSprite(canvas, suitSprite, Vector2(.3, .2), rotate: true);
        _drawSprite(canvas, suitSprite, Vector2(.7, .2), rotate: true);
        _drawSprite(canvas, suitSprite, Vector2(.5, .3), rotate: true);
        _drawSprite(canvas, suitSprite, Vector2(.3, .4), rotate: true);
        _drawSprite(canvas, suitSprite, Vector2(.7, .4), rotate: true);
      case 11:
        _drawSprite(
          canvas,
          suit.isRed ? redJack : blackJack,
          Vector2(.5, .5),
        );
      case 12:
        _drawSprite(
          canvas,
          suit.isRed ? redQueen : blackQueen,
          Vector2(.5, .5),
        );
      case 13:
        _drawSprite(
          canvas,
          suit.isRed ? redKing : blackKing,
          Vector2(.5, .5),
        );
    }
  }

  void _drawSprite(
    Canvas canvas,
    Sprite sprite,
    Vector2 relativeLocation, {
    double scale = 1,
    bool rotate = false,
  }) {
    if (rotate) {
      canvas
        ..save()
        ..translate(size.x / 2, size.y / 2)
        ..rotate(pi)
        ..translate(-size.x / 2, -size.y / 2);
    }

    sprite.render(
      canvas,
      position:
          Vector2(relativeLocation.x * size.x, relativeLocation.y * size.y),
      size: sprite.srcSize.scaled(scale),
      anchor: Anchor.center,
    );

    if (rotate) {
      canvas.restore();
    }
  }

  @override
  String toString() => "${rank.label} ${suit.label}";
}
