import "dart:async";

import "package:flame/collisions.dart";
import "package:flame/components.dart";

class Bullet extends SpriteAnimationComponent with HasGameRef {
  Bullet({
    super.position,
  }) : super(
          size: Vector2(25, 50),
          anchor: Anchor.center,
        );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      "space_shooter/bullet.png",
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.15,
        textureSize: Vector2(8, 16),
      ),
    );

    add(
      RectangleHitbox(
        collisionType: CollisionType.passive,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += dt * -500;
    if (position.y < -height) {
      removeFromParent();
    }
  }
}
