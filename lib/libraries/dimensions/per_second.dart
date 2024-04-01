extension TimesPerSecondDoubleX on double {
  double get timesPerSecond => this != 0 ? 1.0 / this : 0;
}

extension TimesPerSecondIntX on int {
  double get timesPerSecond => toDouble().timesPerSecond;
}
