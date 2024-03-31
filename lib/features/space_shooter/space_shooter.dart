import "dart:async";

import "package:flame/events.dart";
import "package:flame/game.dart";

import "enemy/enemy_spawner.dart";
import "outer_space.dart";
import "spaceship.dart";
import "stars.dart";

// https://docs.flame-engine.org/latest/tutorials/space_shooter/space_shooter.html
class SpaceShooter extends FlameGame
    with
        HasCollisionDetection,
        MouseMovementDetector,
        PanDetector,
        SingleGameInstance {
  late Spaceship player;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    add(EnemySpawner());
    add(OuterSpace());
    add(Stars());
    add(player = Spaceship());
  }

  @override
  void onMouseMove(PointerHoverInfo info) {
    player.position = info.eventPosition.widget;
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.position = info.eventPosition.widget;
  }
}
