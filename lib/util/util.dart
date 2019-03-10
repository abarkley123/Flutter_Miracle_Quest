String truncateBigValue(double value) {
  double val = value.abs();
  if (val >= 1000000000000) {
    return (value / 1000000000000).toStringAsFixed(1) + "T";
  } else if (val >= 1000000000) {
    return (value / 1000000000).toStringAsFixed(1) + "B";
  } else if (val >= 1000000) {
    return (value / 1000000).toStringAsFixed(1) + "M";
  } else if (val >= 1000) {
    return (value / 1000).toStringAsFixed(1) + "K";
  } else {
    return value.toStringAsFixed(1);
  }
}