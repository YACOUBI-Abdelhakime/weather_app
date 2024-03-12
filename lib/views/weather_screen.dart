import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/models/enums/event_status.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
        builder: (BuildContext blocContext, WeatherState weatherState) {
      return Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 27, 148, 248),
                Color.fromARGB(255, 124, 201, 249),
              ],
            ),
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  blocContext.read<WeatherBloc>().add(WeatherActualFetch());
                },
                child: Container(
                  color: const Color.fromARGB(255, 58, 243, 33),
                  child: const Text('Get weather'),
                ),
              ),
              const SizedBox(height: 20),
              if (weatherState.status == EventStatus.loading) ...[
                const CircularProgressIndicator(
                  color: Colors.green,
                ),
              ] else ...[
                Container(
                    width: 200,
                    color: Colors.pink,
                    child: Column(
                      children: [
                        Text("City: ${weatherState.weatherModel?.cityName}"),
                        Text(
                            "TemperatureAct: ${weatherState.weatherModel?.temperatureActual}"),
                        Text("desc: ${weatherState.weatherModel?.description}"),
                        Text(
                            "humidity: ${weatherState.weatherModel?.humidity}"),
                        Text("sunset: ${weatherState.weatherModel?.sunset}"),
                      ],
                    )),
              ]
            ],
          ),
        ),
      );
    });
  }
}
