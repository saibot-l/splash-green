import "dart:async";

import "package:flame/components.dart";

import "bullet/bullet_spawner.dart";

class Spaceship extends SpriteAnimationComponent with HasGameRef {
  Spaceship()
      : super(
          anchor: Anchor.center,
          size: Vector2(50, 100),
        );

  late final SpawnComponent _bulletSpawner;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      "space_shooter/spaceship.png",
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .15,
        textureSize: Vector2(32, 48),
      ),
    );

    _bulletSpawner = BulletSpawner(player: this);
    game.add(_bulletSpawner);

    position = game.size / 2;
  }
}
