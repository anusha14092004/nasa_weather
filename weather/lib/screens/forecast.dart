import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/meteomatics_service.dart';

class ForecastScreen extends StatefulWidget {
  final double lat, lon;
  const ForecastScreen({required this.lat, required this.lon, super.key});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  List<DailySummary>? forecast;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    MeteomaticsService().fetch7DayForecast(widget.lat, widget.lon).then((data) {
      setState(() { forecast = data; loading = false; });
    }).catchError((e) { setState(() { loading = false; }); });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("7-Day Forecast")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: forecast?.length ?? 0,
              itemBuilder: (context, index) {
                final day = forecast![index];
                return Card(
                  child: ListTile(
                    title: Text(day.readableDate()),
                    subtitle: Text("Temp: ${day.minTempC}-${day.maxTempC}°C\n"
                        "Humidity: ${day.humidity}%\nWind: ${day.windMs} m/s\nPrecip: ${day.precipMm} mm"),
                  ),
                );
              },
            ),
    );
  }
}
