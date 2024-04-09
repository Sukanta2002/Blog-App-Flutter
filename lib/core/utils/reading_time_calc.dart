int readingTimeCalc(String content) {
  final words = content.split(RegExp(r'\s+')).length;
  final readingTime = words / 200;
  return readingTime.ceil();
}
