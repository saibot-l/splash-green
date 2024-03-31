import "dart:async";

import "package:flame/components.dart";
import "package:flame/experimental.dart";

import "enemy.dart";

class EnemySpawner extends SpawnComponent with HasGameRef {
  EnemySpawner()
      : super(
          factory: (index) => Enemy(),
          period: 1,
        );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    area = _computeArea();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    area = _computeArea();
  }

  Shape _computeArea() => Rectangle.fromLTRB(
        kEnemySize / 2,
        0,
        game.size.x - kEnemySize / 2,
        -kEnemySize,
      );
}
