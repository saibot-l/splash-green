import "package:flame/game.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

import "../features/space_shooter/space_shooter.dart";

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
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
    properties.add(DiagnosticsProperty<SpaceShooter>("spaceShooter", spaceShooter));
  }
}
