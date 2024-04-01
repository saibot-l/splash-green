import "dart:math";

import "package:flame/game.dart";
import "package:flutter/rendering.dart";

import "../../libraries/dimensions/per_second.dart";

abstract class Splatting {
  const Splatting._();

  static final splatRate = 20.timesPerSecond;

  static const jitter = 30.0;

  static const nonDirectionalMinAngle = 0.0;
  static const nonDirectionalMaxAngle = 2 * pi;

  static final baseOrientation = Vector2(1, 0);
  static const directionalAngleVariation = pi / 4;

  static const baseColor = HSVColor.fromAHSV(1.0, 79.0, .83, .69);
  static const hueVariation = 20.0;

  static const minSize = 300.0;
  static const maxSize = 400.0;
}
