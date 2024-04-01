import "dart:ui";

import "package:flame/components.dart";

import "../../../libraries/constants/colors.dart";
import "../klondike.dart";

class Background extends Component with HasGameRef<Klondike> {
  static final _paint = Paint()..color = kBlack;

  @override
  void render(Canvas canvas) {
    canvas.drawRect(game.size.toRect(), _paint);
  }
}
