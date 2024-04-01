import "dart:ui";

import "../constants/dimensions.dart";

abstract class CardBackPaint {
  const CardBackPaint._();

  static get background => Paint()..color = const Color.fromARGB(255, 48, 6, 3);

  static get border => Paint()
    ..color = const Color.fromARGB(255, 131, 94, 9)
    ..strokeWidth = kCardBorderWidthM
    ..style = PaintingStyle.stroke;
}
