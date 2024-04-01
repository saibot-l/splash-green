import "package:flame/components.dart";
import "package:flutter/material.dart";

class Cursor extends PositionComponent {
  Cursor(Color color)
      : borderPaint = Paint()
          ..isAntiAlias = true
          ..color = color.withOpacity(borderOpacity)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke,
        innerPaint = Paint()
          ..isAntiAlias = true
          ..color = color.withOpacity(innerOpacity);

  static const borderOpacity = 0.2;
  static const innerOpacity = 0.6;

  Paint borderPaint;
  Paint innerPaint;
  bool visible = false;

  set color(Color value) {
    borderPaint = borderPaint..color = value.withOpacity(borderOpacity);
    innerPaint = innerPaint..color = value.withOpacity(innerOpacity);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (!visible) return;

    canvas
      ..drawCircle(Offset.zero, 3, innerPaint)
      ..drawCircle(Offset.zero, 12, borderPaint);
  }
}
