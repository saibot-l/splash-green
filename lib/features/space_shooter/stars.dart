import "dart:async";

import "package:flame/components.dart";
import "package:flame/parallax.dart";
import "package:flutter/painting.dart";

class Stars extends ParallaxComponent with HasGameRef {
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    parallax = await game.loadParallax(
      [
        ParallaxImageData("space_shooter/stars_0.png"),
        ParallaxImageData("space_shooter/stars_1.png"),
        ParallaxImageData("space_shooter/stars_2.png"),
      ],
      baseVelocity: Vector2(0, -5),
      repeat: ImageRepeat.repeat,
      velocityMultiplierDelta: Vector2(0, 5),
    );
  }
}
