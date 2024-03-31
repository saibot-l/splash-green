import "dart:ui";

import "package:flame/components.dart";

import "../../libraries/constants/colors.dart";

class OuterSpace extends Component with HasGameRef {
  static final _paint = Paint()..color = kBlack;

  @override
  void render(Canvas canvas) {
    canvas.drawRect(game.size.toRect(), _paint);
  }
}
