import "package:flame/game.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";

import "../features/klondike/klondike.dart";

class KlondikeGame extends StatefulWidget {
  const KlondikeGame({super.key});

  @override
  State<KlondikeGame> createState() => _KlondikeGameState();
}

class _KlondikeGameState extends State<KlondikeGame> {
  late Klondike klondike;

  @override
  void initState() {
    super.initState();

    klondike = Klondike();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: klondike,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Klondike>("klondike", klondike));
  }
}
