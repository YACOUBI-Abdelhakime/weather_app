import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PrincipalWeatherData extends StatelessWidget {
  final String weatherIcon;
  final String weatherDescription;
  final int weatherTemperature;
  final int weatherTemperatureFeelsLike;
  final int weatherTemperatureMin;
  final int weatherTemperatureMax;

  const PrincipalWeatherData({
    super.key,
    required this.weatherIcon,
    required this.weatherDescription,
    required this.weatherTemperature,
    required this.weatherTemperatureFeelsLike,
    required this.weatherTemperatureMin,
    required this.weatherTemperatureMax,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Lottie.asset(
                    'assets/weather_icons/$weatherIcon.json',
                    height: 70,
                  ),
                ),
                Text(
                  weatherDescription,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                '${weatherTemperature.toString()} °C',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ressenti ${weatherTemperatureFeelsLike.toString()}°C',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Min ${weatherTemperatureMin.toString()}°C',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Max ${weatherTemperatureMax.toString()}°C',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
