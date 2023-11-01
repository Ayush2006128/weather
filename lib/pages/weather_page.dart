import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/services/weather_service.dart';

import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('bbc5c2185ca2dce56ef3c4296eb45b14');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);

      setState(() {
        _weather = weather;
      });
    } catch (e) {
      rethrow;
    }
  }

  String setAnim(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/thunderstorm_image.png';
      case 'fog':
        return 'assets/drizzle_image.png';
      case 'smoke':
        return 'assets/rain_image.png';
      case 'snow':
        return 'assets/snow_image.png';
      case 'haze':
        return 'assets/atmosphere_image.png';
      case 'drizzle':
        return 'assets/snow_image.png';
      case 'mist':
        return 'assets/atmosphere_image.png';
      case 'clear':
        return 'assets/sunny.json';
      case 'rain':
      case 'shower rain':
        return 'assets/rainy.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_city_rounded),
            Text(_weather?.cityName ?? "Loding city..."),
            Lottie.asset(setAnim(_weather?.mainCondition)),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("${_weather?.temperature}*C"),
              Icon(Icons.thermostat),
            ]),
            Text(_weather?.mainCondition ?? "Loding weather..."),
          ],
        ),
      ),
    );
  }
}
