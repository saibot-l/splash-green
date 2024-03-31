import "dart:async";

import "package:flame/collisions.dart";
import "package:flame/components.dart";

import "../bullet/bullet.dart";
import "../explosion.dart";

const kEnemySize = 50.0;

class Enemy extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef {
  Enemy({
    super.position,
  }) : super(
          size: Vector2.all(kEnemySize),
          anchor: Anchor.center,
        );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      "space_shooter/enemy.png",
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.15,
        textureSize: Vector2.all(16),
      ),
    );

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += dt * 250;

    if (position.y > game.size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) async {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Bullet) {
      removeFromParent();
      other.removeFromParent();
      await game.add(Explosion(position: position));
    }
  }
}
