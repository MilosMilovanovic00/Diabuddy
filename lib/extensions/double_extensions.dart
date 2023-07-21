extension DoubleExtension on double {
  double convertIfStandardUnit(bool isStandardUnit, double value) {
    return isStandardUnit ? value : (value * 18);
  }
}
