import "package:flame/components.dart";
import "package:flutter/foundation.dart";

import "../utils/klondike_sprite.dart";

@immutable
class Suit {
  Suit._({
    required this.value,
    required this.label,
    required Vector2 spritePosition,
    required Vector2 spriteSize,
  }) : sprite = klondikeSprite(
          position: spritePosition,
          size: spriteSize,
        );

  factory Suit.fromInt(int index) {
    assert(index >= 0 && index <= 3);
    return _singletons[index];
  }

  static final _singletons = [
    Suit._(
      value: 0,
      label: "♥",
      spritePosition: Vector2(1176, 17),
      spriteSize: Vector2(172, 183),
    ),
    Suit._(
      value: 1,
      label: "♦",
      spritePosition: Vector2(973, 14),
      spriteSize: Vector2(177, 182),
    ),
    Suit._(
      value: 2,
      label: "♣",
      spritePosition: Vector2(974, 226),
      spriteSize: Vector2(184, 172),
    ),
    Suit._(
      value: 3,
      label: "♠",
      spritePosition: Vector2(1178, 220),
      spriteSize: Vector2(176, 182),
    ),
  ];

  final int value;
  final String label;
  final Sprite sprite;

  bool get isRed => value <= 1;
  bool get isBlack => value >= 2;
}
