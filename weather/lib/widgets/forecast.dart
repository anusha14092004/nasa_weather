import 'package:flutter/material.dart';
import '../models/weather.dart';

class ForecastCard extends StatelessWidget {
  final DailySummary forecast;

  const ForecastCard({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              forecast.readableDate(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text("Temp: ${forecast.minTempC ?? '-'}°C - ${forecast.maxTempC ?? '-'}°C"),
            Text("Humidity: ${forecast.avgHumidity ?? '-'}%"),
            Text("Precipitation: ${forecast.totalPrecipMm ?? '-'} mm"),
            Text("Wind: ${forecast.windLabel()}"),
            Text("Heat Index: ${forecast.heatIndexC ?? '-'}°C"),
          ],
        ),
      ),
    );
  }
}
