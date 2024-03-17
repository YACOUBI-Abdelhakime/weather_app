// Weather model

class Weather {
  double? latitude;
  double? longitude;
  String? cityName;
  final String description;
  final String icon;
  final int temperatureActual;
  final int temperatureFeelsLike;
  final int temperatureMin;
  final int temperatureMax;
  final int humidity;
  DateTime? sunrise;
  DateTime? sunset;
  final DateTime weatherDate;

  Weather({
    required this.latitude,
    required this.longitude,
    required this.cityName,
    required this.description,
    required this.icon,
    required this.temperatureActual,
    required this.temperatureFeelsLike,
    required this.temperatureMin,
    required this.temperatureMax,
    required this.humidity,
    required this.sunrise,
    required this.sunset,
    required this.weatherDate,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        latitude: json['coord']?['lat']?.toDouble(),
        longitude: json['coord']?['lon']?.toDouble(),
        cityName: json['name'],
        description: json['weather'][0]['description'],
        icon: json['weather'][0]['icon'].substring(0, 2),
        temperatureActual: json['main']['temp'].toDouble().truncate(),
        temperatureFeelsLike: json['main']['feels_like'].toDouble().truncate(),
        temperatureMin: json['main']['temp_min'].toDouble().truncate(),
        temperatureMax: json['main']['temp_max'].toDouble().truncate(),
        humidity: json['main']['humidity'].toDouble().truncate(),
        sunrise: json['sys']?['sunrise'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000,
                isUtc: false)
            : null,
        sunset: json['sys']?['sunset'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000,
                isUtc: false)
            : null,
        weatherDate: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000,
            isUtc: false),
      );

  Map<String, dynamic> toJson() => {
        'coord': {
          'lat': latitude,
          'lon': longitude,
        },
        'name': cityName,
        'dt': weatherDate.millisecondsSinceEpoch ~/ 1000,
        'weather': [
          {
            'description': description,
            'icon': icon,
          }
        ],
        'main': {
          'temp': temperatureActual,
          'feels_like': temperatureFeelsLike,
          'temp_min': temperatureMin,
          'temp_max': temperatureMax,
          'humidity': humidity,
        },
        'sys': {
          'sunrise': sunrise?.millisecondsSinceEpoch ?? 0 ~/ 1000,
          'sunset': sunset?.millisecondsSinceEpoch ?? 0 ~/ 1000,
        },
      };
}
