import "dart:math";

import "package:flame/components.dart";
import "package:flame/experimental.dart";

import "splat.dart";
import "splatting.dart";

typedef GetOrientation = Vector2? Function();

class SplatEmitter extends SpawnComponent {
  SplatEmitter(
    Random random, {
    required GetOrientation getDirection,
    super.autoStart,
  }) : super(
          factory: (index) => Splat.directional(
            random,
            orientation: getDirection(),
          ),
          period: Splatting.splatRate,
        );

  set center(Vector2 center) {
    area = Circle(center, Splatting.jitter);
  }
}
