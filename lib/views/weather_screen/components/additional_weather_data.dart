import 'package:flutter/material.dart';
import 'package:weather_app/views/weather_screen/widgets/icon_value_widget.dart';

class AdditionalWeatherData extends StatelessWidget {
  final String sunrise;
  final String sunset;
  final int humidity;

  const AdditionalWeatherData({
    super.key,
    required this.sunrise,
    required this.sunset,
    required this.humidity,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconValueWidget(
            icon: Icons.light_mode_outlined,
            value: sunrise,
          ),
          IconValueWidget(
            icon: Icons.wb_twilight_outlined,
            value: sunset,
          ),
          IconValueWidget(
            icon: Icons.water_drop_outlined,
            value: '${humidity.toString()}%',
          ),
        ],
      ),
    );
  }
}
