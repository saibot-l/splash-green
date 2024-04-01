import "package:flame/components.dart";
import "package:flame/flame.dart";

Sprite klondikeSprite({
  required Vector2 position,
  required Vector2 size,
}) =>
    Sprite(
      Flame.images.fromCache("klondike/sprites.png"),
      srcPosition: position,
      srcSize: size,
    );
