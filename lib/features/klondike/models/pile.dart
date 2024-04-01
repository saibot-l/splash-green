import "package:flutter/foundation.dart";

import "../components/card.dart";

abstract mixin class Pile {
  @mustCallSuper
  void acquireCard(Card card) {
    card.pile = this;
  }

  void removeCard(Card card);

  void returnCard(Card card);

  bool canMoveCard(Card card);

  bool canAcceptCard(Card card);
}
