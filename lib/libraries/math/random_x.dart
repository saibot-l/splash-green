import "dart:math";

import "package:flutter/painting.dart";

extension RandomX on Random {
  double nextInRange(double minValue, double maxValue) {
    final start = min(minValue, maxValue);
    final end = max(minValue, maxValue);
    return start + nextDouble() * (end - start);
  }

  HSVColor nextColorAHSV({
    double minAlpha = 1.0,
    double maxAlpha = 1.0,
    double minHue = 0.0,
    double maxHue = 360.0,
    double minSaturation = 0.0,
    double maxSaturation = 1.0,
    double minValue = 0.0,
    double maxValue = 1.0,
  }) {
    assert(minAlpha >= 0.0);
    assert(maxAlpha <= 1.0);
    assert(maxAlpha >= minAlpha);

    assert(minSaturation >= 0.0);
    assert(maxSaturation <= 1.0);
    assert(maxSaturation >= minSaturation);

    assert(minValue >= 0.0);
    assert(maxValue <= 1.0);
    assert(maxValue >= minValue);

    return HSVColor.fromAHSV(
      nextInRange(minAlpha, maxAlpha),
      nextInRange(minHue, maxHue) % 360.0,
      nextInRange(minSaturation, maxSaturation),
      nextInRange(minValue, maxValue),
    );
  }
}
