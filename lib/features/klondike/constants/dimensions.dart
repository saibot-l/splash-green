import "dart:ui";

import "package:flame/game.dart";

const kCardWidth = 1000.0;
const kCardHeight = 1400.0;
const kCardGap = 175.0;
const kCardRadius = 100.0;

const kCardBorderWidthS = 10.0;
const kCardBorderWidthM = 15.0;
const kCardBorderWidthL = 20.0;

final cardSize = Vector2(kCardWidth, kCardHeight);
final cardRRect = RRect.fromRectAndRadius(
  cardSize.toRect(),
  const Radius.circular(kCardRadius),
);

final viewportSize = Vector2(
  kCardWidth * 7 + kCardGap * 8,
  4 * kCardHeight + 3 * kCardGap,
);
