import "package:flame/components.dart";
import "package:flutter/foundation.dart";

import "../utils/klondike_sprite.dart";

@immutable
class Rank {
  Rank._({
    required this.value,
    required this.label,
    required Vector2 redSpritePosition,
    required Vector2 blackSpritePosition,
    required Vector2 spriteSize,
  })  : redSprite = klondikeSprite(
          position: redSpritePosition,
          size: spriteSize,
        ),
        blackSprite = klondikeSprite(
          position: blackSpritePosition,
          size: spriteSize,
        );

  factory Rank.fromInt(int value) {
    assert(value >= 1 && value <= 13);
    return _singletons[value - 1];
  }

  static final _singletons = [
    Rank._(
      value: 1,
      label: "A",
      redSpritePosition: Vector2(335, 164),
      blackSpritePosition: Vector2(789, 161),
      spriteSize: Vector2(120, 129),
    ),
    Rank._(
      value: 2,
      label: "2",
      redSpritePosition: Vector2(20, 19),
      blackSpritePosition: Vector2(15, 322),
      spriteSize: Vector2(83, 125),
    ),
    Rank._(
      value: 3,
      label: "3",
      redSpritePosition: Vector2(122, 19),
      blackSpritePosition: Vector2(117, 322),
      spriteSize: Vector2(80, 127),
    ),
    Rank._(
      value: 4,
      label: "4",
      redSpritePosition: Vector2(213, 12),
      blackSpritePosition: Vector2(208, 315),
      spriteSize: Vector2(93, 132),
    ),
    Rank._(
      value: 5,
      label: "5",
      redSpritePosition: Vector2(314, 21),
      blackSpritePosition: Vector2(309, 324),
      spriteSize: Vector2(85, 125),
    ),
    Rank._(
      value: 6,
      label: "6",
      redSpritePosition: Vector2(419, 17),
      blackSpritePosition: Vector2(414, 320),
      spriteSize: Vector2(84, 129),
    ),
    Rank._(
      value: 7,
      label: "7",
      redSpritePosition: Vector2(509, 21),
      blackSpritePosition: Vector2(505, 324),
      spriteSize: Vector2(92, 128),
    ),
    Rank._(
      value: 8,
      label: "8",
      redSpritePosition: Vector2(612, 19),
      blackSpritePosition: Vector2(607, 322),
      spriteSize: Vector2(78, 127),
    ),
    Rank._(
      value: 9,
      label: "9",
      redSpritePosition: Vector2(709, 19),
      blackSpritePosition: Vector2(704, 322),
      spriteSize: Vector2(84, 130),
    ),
    Rank._(
      value: 10,
      label: "10",
      redSpritePosition: Vector2(810, 20),
      blackSpritePosition: Vector2(805, 322),
      spriteSize: Vector2(137, 127),
    ),
    Rank._(
      value: 11,
      label: "J",
      redSpritePosition: Vector2(15, 170),
      blackSpritePosition: Vector2(469, 167),
      spriteSize: Vector2(56, 126),
    ),
    Rank._(
      value: 12,
      label: "Q",
      redSpritePosition: Vector2(92, 168),
      blackSpritePosition: Vector2(547, 165),
      spriteSize: Vector2(132, 128),
    ),
    Rank._(
      value: 13,
      label: "K",
      redSpritePosition: Vector2(243, 170),
      blackSpritePosition: Vector2(696, 167),
      spriteSize: Vector2(92, 123),
    ),
  ];

  final int value;
  final String label;
  final Sprite redSprite;
  final Sprite blackSprite;
}
