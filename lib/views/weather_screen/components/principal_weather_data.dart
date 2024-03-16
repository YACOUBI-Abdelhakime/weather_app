import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/shared/helpers.dart';

class PrincipalWeatherData extends StatelessWidget {
  final Weather? weather;

  const PrincipalWeatherData({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
      constraints: const BoxConstraints(
        minHeight: 170,
      ),
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
      child: weather != null
          ? Row(
              children: [
                // Weather icon and description
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Lottie.asset(
                          'assets/weather_icons/${weather?.icon ?? '01'}.json',
                          height: 70,
                        ),
                      ),
                      Text(
                        Helpers().capitalize(weather?.description ?? ''),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // Weather temperature data
                Expanded(
                  child: Center(
                    child: Text(
                      '${weather?.temperatureActual.toString()} °C',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
                // Weather additional data
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ressenti ${weather?.temperatureFeelsLike.toString()}°C',
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Min ${weather?.temperatureMin.toString()}°C',
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Max ${weather?.temperatureMax.toString()}°C',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : const SizedBox(),
    );
  }
}
