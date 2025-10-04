class DailySummary {
  DateTime date;
  double minTempC;
  double maxTempC;
  double humidity;
  double windMs;
  double precipMm;

  DailySummary({
    required this.date,
    required this.minTempC,
    required this.maxTempC,
    required this.humidity,
    required this.windMs,
    required this.precipMm,
  });

  String readableDate() => "${date.day}-${date.month}-${date.year}";
}
