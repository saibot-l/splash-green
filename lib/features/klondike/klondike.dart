import "dart:async";

import "package:flame/flame.dart";
import "package:flame/game.dart";
import "package:flame/particles.dart";

import "components/background.dart";
import "components/card.dart";
import "components/foundation_pile.dart";
import "components/stock_pile.dart";
import "components/tableau_pile.dart";
import "components/waste_pile.dart";
import "constants/dimensions.dart";

// https://docs.flame-engine.org/latest/tutorials/klondike/klondike.html
class Klondike extends FlameGame with SingleGameInstance {
  // Either 1 or 3
  final int klondikeDraw = 3;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    camera.viewfinder.visibleGameSize = viewportSize;
    camera.viewfinder.position = Vector2(viewportSize.x / 2, 0);
    camera.viewfinder.anchor = Anchor.topCenter;

    await Flame.images.load("klondike/sprites.png");

    final background = Background();

    final stock = StockPile(
      position: Vector2.all(kCardGap),
    );

    final waste = WastePile(
      position: Vector2(kCardWidth + 2 * kCardGap, kCardGap),
    );

    final foundations = List.generate(
      4,
      (index) => FoundationPile(
        position: Vector2(
          (index + 3) * (kCardWidth + kCardGap) + kCardGap,
          kCardGap,
        ),
        suit: index,
      ),
    );

    final piles = List.generate(
      7,
      (index) => TableauPile(
        position: Vector2(
          kCardGap + index * (kCardWidth + kCardGap),
          kCardHeight + 2 * kCardGap,
        ),
      ),
    );

    await add(background);
    await world.add(stock);
    await world.add(waste);
    await world.addAll(foundations);
    await world.addAll(piles);

    final cards = [
      for (int rank = 1; rank <= 13; rank++)
        for (int suit = 0; suit < 4; suit++)
          Card(
            rank: rank,
            suit: suit,
          ),
    ]..shuffle();
    await world.addAll(cards);

    int cardsToDeal = cards.length - 1;
    for (int i = 0; i < 7; i++) {
      for (int j = i; j < 7; j++) {
        piles[j].acquireCard(cards[cardsToDeal--]);
      }
      piles[i].flipTopCard();
    }
    for (int n = 0; n <= cardsToDeal; n++) {
      stock.acquireCard(cards[n]);
    }
  }
}
