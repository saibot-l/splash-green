import "dart:ui";

import "../constants/colors.dart";

abstract class CardColorFilter {
  const CardColorFilter._();

  static get black => Paint()
    ..colorFilter =
        ColorFilter.mode(kCardBlack.withOpacity(0.15), BlendMode.srcATop);

  static get red => Paint()
    ..colorFilter =
        ColorFilter.mode(kCardRed.withOpacity(0.15), BlendMode.srcATop);
}
