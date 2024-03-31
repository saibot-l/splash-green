import "dart:async";

import "package:flame/components.dart";

class Explosion extends SpriteAnimationComponent with HasGameRef {
  Explosion({super.position})
      : super(
          size: Vector2.all(150),
          anchor: Anchor.center,
          removeOnFinish: true,
        );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      "space_shooter/explosion.png",
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: .1,
        textureSize: Vector2.all(32),
        loop: false,
      ),
    );
  }
}
