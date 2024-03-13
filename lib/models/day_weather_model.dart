import 'package:weather_app/models/weather_model.dart';

class DayWeather {
  final DateTime day;
  final List<Weather> weathers;

  DayWeather({
    required this.day,
    required this.weathers,
  });

  factory DayWeather.fromJson(Map<String, dynamic> json) {
    return DayWeather(
      day: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true),
      weathers: json['list']
          .map<Weather>((weather) => Weather.fromJson(weather))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': day.millisecondsSinceEpoch ~/ 1000,
      'list': weathers.map((weather) => weather.toJson()).toList(),
    };
  }
}
