import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/weather.dart';

class MeteomaticsService {
  Future<List<DailySummary>> fetch7DayForecast(double lat, double lon) async {
    final now = DateTime.now().toUtc();
    final end = now.add(const Duration(days: 7));
    final startStr = now.toIso8601String();
    final endStr = end.toIso8601String();

    final params = "t_2m:C,relative_humidity_2m:p,wind_speed_10m:ms,precip_1h:mm";
    final url = "https://api.meteomatics.com/$startStr--$endStr:PT1H/$params/$lat,$lon/json";

    final headers = {
      'Authorization': 'Basic ${base64Encode(utf8.encode("$METEOMATICS_USERNAME:$METEOMATICS_PASSWORD"))}',
    };

    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode != 200) throw Exception("Failed to fetch weather");

    final data = jsonDecode(response.body);

    List<DailySummary> daily = [];
    for (int i = 0; i < 7; i++) {
      daily.add(DailySummary(
        date: DateTime.now().add(Duration(days: i)),
        minTempC: data[0]['coordinates'][0]['dates'][i]['value'].toDouble(),
        maxTempC: data[0]['coordinates'][0]['dates'][i]['value'].toDouble() + 5,
        humidity: data[1]['coordinates'][0]['dates'][i]['value'].toDouble(),
        windMs: data[2]['coordinates'][0]['dates'][i]['value'].toDouble(),
        precipMm: data[3]['coordinates'][0]['dates'][i]['value'].toDouble(),
      ));
    }
    return daily;
  }
}
