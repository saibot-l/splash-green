import "dart:async";
import "dart:math";

import "package:flame/components.dart";
import "package:flame/sprite.dart";
import "package:flutter/material.dart";

import "../../libraries/math/random_x.dart";
import "splat_painter.dart";
import "splatting.dart";

class Splat extends SpriteComponent with HasGameRef<SplatPainter> {
  Splat(
    this.splatIndex, {
    required this.color,
    super.anchor,
    super.angle,
    super.position,
    super.size,
  }) : assert(splatIndex >= 0 && splatIndex < numberOfSplats);

  factory Splat.positioned(
    Random random, {
    Vector2? position,
  }) {
    return Splat(
      random.nextInt(Splat.numberOfSplats - 1),
      angle: random.nextInRange(
        Splatting.nonDirectionalMinAngle,
        Splatting.nonDirectionalMaxAngle,
      ),
      color: random
          .nextColorAHSV(
            minAlpha: Splatting.baseColor.alpha,
            maxAlpha: Splatting.baseColor.alpha,
            minHue: Splatting.baseColor.hue - hueVariation,
            maxHue: Splatting.baseColor.hue + hueVariation,
            minSaturation: Splatting.baseColor.saturation,
            maxSaturation: Splatting.baseColor.saturation,
            minValue: Splatting.baseColor.value,
            maxValue: Splatting.baseColor.value,
          )
          .toColor(),
      position: position,
      size: Vector2.all(
        random.nextInRange(
          Splatting.minSize,
          Splatting.maxSize,
        ),
      ),
    );
  }

  factory Splat.directional(
    Random random, {
    Vector2? orientation,
  }) {
    final angle = Splatting.baseOrientation
        .angleToSigned(orientation ?? Splatting.baseOrientation);

    return Splat(
      random.nextInt(Splat.numberOfSplats - 1),
      angle: random.nextInRange(
        angle - Splatting.directionalAngleVariation / 2,
        angle + Splatting.directionalAngleVariation / 2,
      ),
      color: random
          .nextColorAHSV(
            minAlpha: Splatting.baseColor.alpha,
            maxAlpha: Splatting.baseColor.alpha,
            minHue: Splatting.baseColor.hue - hueVariation,
            maxHue: Splatting.baseColor.hue + hueVariation,
            minSaturation: Splatting.baseColor.saturation,
            maxSaturation: Splatting.baseColor.saturation,
            minValue: Splatting.baseColor.value,
            maxValue: Splatting.baseColor.value,
          )
          .toColor(),
      size: Vector2.all(
        random.nextInRange(
          Splatting.minSize,
          Splatting.maxSize,
        ),
      ),
    );
  }

  static const numberOfSplatsHorizontally = 5;
  static const numberOfSplatsVertically = 5;
  static const numberOfSplats =
      numberOfSplatsHorizontally * numberOfSplatsVertically;

  static const hue = 79.0;
  static const hueVariation = 20.0;
  static const saturation = .83;
  static const value = .69;

  final int splatIndex;
  final Color color;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    anchor = Anchor.center;

    final spriteSheet = SpriteSheet(
      image: await game.images.load("splash_green/watercolor_splats.png"),
      srcSize: Vector2(512, 512),
    );
    sprite = spriteSheet.getSpriteById(splatIndex);

    tint(color);
  }
}
