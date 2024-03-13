import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HourWeatherData extends StatelessWidget {
  final String weatherHour;
  final String weatherIcon;
  final int weatherTemperature;

  const HourWeatherData({
    super.key,
    required this.weatherIcon,
    required this.weatherHour,
    required this.weatherTemperature,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blue,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset.zero,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            '$weatherHour',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          Container(
            child: Lottie.asset(
              'assets/weather_icons/$weatherIcon.json',
              height: 25,
            ),
          ),
          Text(
            '$weatherTemperature°C',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
