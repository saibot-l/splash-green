import "package:flame/components.dart";

import "bullet.dart";

class BulletSpawner extends SpawnComponent {
  BulletSpawner({required this.player})
      : super(
          factory: (index) => Bullet(
            position: player.position + Vector2(0, -player.height / 2),
          ),
          period: 0.15,
          selfPositioning: true,
        );

  final PositionComponent player;
}
