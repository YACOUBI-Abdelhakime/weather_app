import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/views/weather_screen/widgets/icon_value_widget.dart';

class AdditionalWeatherData extends StatelessWidget {
  final Weather? weather;

  const AdditionalWeatherData({
    super.key,
    required this.weather,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      constraints: const BoxConstraints(
        minHeight: 90,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconValueWidget(
                  icon: Icons.light_mode_outlined,
                  value:
                      '${weather?.sunrise?.hour.toString().padLeft(2, '0')}:${weather?.sunrise?.minute.toString().padLeft(2, '0')}',
                ),
                IconValueWidget(
                  icon: Icons.wb_twilight_outlined,
                  value:
                      '${weather?.sunset?.hour.toString().padLeft(2, '0')}:${weather?.sunset?.minute.toString().padLeft(2, '0')}',
                ),
                IconValueWidget(
                  icon: Icons.water_drop_outlined,
                  value: '${weather?.humidity.toString()}%',
                ),
              ],
            )
          : const SizedBox(),
    );
  }
}
