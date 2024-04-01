import "package:flame/game.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";

import "../features/space_shooter/space_shooter.dart";

class SpaceShooterGame extends StatefulWidget {
  const SpaceShooterGame({super.key});

  @override
  State<SpaceShooterGame> createState() => _SpaceShooterGameState();
}

class _SpaceShooterGameState extends State<SpaceShooterGame> {
  late SpaceShooter spaceShooter;

  @override
  void initState() {
    super.initState();

    spaceShooter = SpaceShooter();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: spaceShooter,
      mouseCursor: SystemMouseCursors.none,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<SpaceShooter>("spaceShooter", spaceShooter));
  }
}
