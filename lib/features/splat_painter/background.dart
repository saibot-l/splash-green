import "package:flame/components.dart";
import "package:flutter/material.dart";

import "splat_painter.dart";

class Background extends Component with HasGameRef<SplatPainter> {
  Background(Color color) : paint = Paint()..color = color;

  Paint paint;

  set color(Color value) => paint = paint..color = value;

  @override
  void render(Canvas canvas) {
    canvas.drawRect(game.size.toRect(), paint);
  }
}
