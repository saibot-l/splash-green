import "dart:ui";

import "../constants/dimensions.dart";

abstract class PilePaint {
  const PilePaint._();

  static get emptyBorder => Paint()
    ..color = const Color.fromARGB(255, 63, 73, 76)
    ..strokeWidth = kCardBorderWidthS
    ..style = PaintingStyle.stroke;

  static get border => Paint()
    ..color = const Color.fromARGB(255, 90, 107, 112)
    ..strokeWidth = kCardBorderWidthS
    ..style = PaintingStyle.stroke;

  static get emptyCircle => Paint()
    ..color = const Color.fromARGB(255, 63, 73, 76)
    ..strokeWidth = 100
    ..style = PaintingStyle.stroke;

  static get suit => Paint()
    ..color = const Color.fromARGB(42, 0, 0, 0)
    ..blendMode = BlendMode.dstOut;
}
