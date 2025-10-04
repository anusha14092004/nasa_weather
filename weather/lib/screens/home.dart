import 'package:flutter/material.dart';
import 'forecast_screen.dart';
import '../models/activity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _latController = TextEditingController(text: "15.5");
  final _lonController = TextEditingController(text: "73.8");
  ActivityPreset _selectedActivity = ActivityPreset.hiking;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather App")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(controller: _latController, decoration: const InputDecoration(labelText: "Latitude")),
            TextField(controller: _lonController, decoration: const InputDecoration(labelText: "Longitude")),
            DropdownButton<ActivityPreset>(
              value: _selectedActivity,
              items: ActivityPreset.values.map((e) => DropdownMenuItem(value: e, child: Text(e.name))).toList(),
              onChanged: (val) { if (val != null) setState(() => _selectedActivity = val); },
            ),
            ElevatedButton(
              onPressed: () {
                final lat = double.tryParse(_latController.text);
                final lon = double.tryParse(_lonController.text);
                if (lat != null && lon != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ForecastScreen(lat: lat, lon: lon),
                    ),
                  );
                }
              },
              child: const Text("Fetch Forecast"),
            )
          ],
        ),
      ),
    );
  }
}
