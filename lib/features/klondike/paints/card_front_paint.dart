import "dart:ui";

import "../../../libraries/constants/colors.dart";
import "../constants/colors.dart";
import "../constants/dimensions.dart";

abstract class CardFrontPaint {
  const CardFrontPaint._();

  static get background => Paint()..color = kBlack;

  static get blackBorder => Paint()
    ..color = kCardBlack
    ..strokeWidth = kCardBorderWidthL
    ..style = PaintingStyle.stroke;

  static get redBorder => Paint()
    ..color = kCardRed
    ..strokeWidth = kCardBorderWidthL
    ..style = PaintingStyle.stroke;
}
