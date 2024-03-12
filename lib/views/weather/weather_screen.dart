import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/views/weather/components/additional_weather_data.dart';
import 'package:weather_app/views/weather/components/principal_weather_data.dart';

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
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.refresh_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              blocContext.read<WeatherBloc>().add(WeatherActualFetch());
            },
          ),
          title: Center(
            child: Text(
              weatherState.weatherModel?.cityName ?? 'City Name',
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.blue,
          actions: [
            Builder(builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            }),
          ],
        ),
        endDrawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Text('Ajouter une ville'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Choisir une ville'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Météo actuelle'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Container(
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Actual weather block
              PrincipalWeatherData(
                weatherIcon: weatherState.weatherModel?.icon ?? '01',
                weatherDescription:
                    weatherState.weatherModel?.description ?? '',
                weatherTemperature:
                    weatherState.weatherModel?.temperatureActual ?? 0,
                weatherTemperatureFeelsLike:
                    weatherState.weatherModel?.temperatureFeelsLike ?? 0,
                weatherTemperatureMin:
                    weatherState.weatherModel?.temperatureMin ?? 0,
                weatherTemperatureMax:
                    weatherState.weatherModel?.temperatureMax ?? 0,
              ),
              // Additional weather data
              AdditionalWeatherData(
                sunrise:
                    '${weatherState.weatherModel?.sunrise.hour.toString().padLeft(2, '0')}:${weatherState.weatherModel?.sunrise.minute.toString().padLeft(2, '0')}',
                sunset:
                    '${weatherState.weatherModel?.sunset.hour.toString().padLeft(2, '0')}:${weatherState.weatherModel?.sunset.minute.toString().padLeft(2, '0')}',
                humidity: weatherState.weatherModel?.humidity ?? 0,
              ),
            ],
          ),
        ),
      );
    });
  }
}
