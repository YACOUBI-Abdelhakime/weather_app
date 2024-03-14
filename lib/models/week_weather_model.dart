import 'package:weather_app/models/weather_model.dart';

class WeekWeather {
  final double latitude;
  final double longitude;
  final String cityName;
  final DateTime sunrise;
  final DateTime sunset;
  final List<Weather> weathers;

  WeekWeather({
    required this.latitude,
    required this.longitude,
    required this.cityName,
    required this.sunrise,
    required this.sunset,
    required this.weathers,
  });

  factory WeekWeather.fromJson(Map<String, dynamic> json) {
    return WeekWeather(
      latitude: json['city']['coord']['lat'].toDouble(),
      longitude: json['city']['coord']['lon'].toDouble(),
      cityName: json['city']['name'],
      sunrise: DateTime.fromMillisecondsSinceEpoch(
          json['city']['sunrise'] * 1000,
          isUtc: true),
      sunset: DateTime.fromMillisecondsSinceEpoch(json['city']['sunset'] * 1000,
          isUtc: true),
      weathers: json['list']
          .map<Weather>((weather) => Weather.fromJson(weather))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': {
        'coord': {
          'lat': latitude,
          'lon': longitude,
        },
        'name': cityName,
        'sunrise': sunrise.millisecondsSinceEpoch ~/ 1000,
        'sunset': sunset.millisecondsSinceEpoch ~/ 1000,
      },
      'list': weathers.map((weather) => weather.toJson()).toList(),
    };
  }
}
