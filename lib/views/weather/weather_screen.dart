import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/location/location_bloc.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/models/enums/event_status.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/views/weather/components/additional_weather_data.dart';
import 'package:weather_app/views/weather/components/hour_weather_data.dart';
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
      List<Weather> dayWeathers = weatherState.getDayWeathers();
      List<Weather> allWeathersExpectTodaysWeather =
          weatherState.getAllWeathersExpectTodaysWeather();

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.location_on_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              blocContext.read<LocationBloc>().add(LocationGetCurrent());
            },
          ),
          title: Center(
            child: Text(
              weatherState.weatherModel?.cityName ?? 'City Name',
              style: const TextStyle(color: Colors.white),
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
        body: BlocListener<LocationBloc, LocationState>(
          listenWhen: (previous, current) =>
              previous.status != current.status &&
              current.status == EventStatus.loaded &&
              current.latitude != null &&
              current.longitude != null,
          listener: (BuildContext context, LocationState locationState) {
            blocContext.read<WeatherBloc>().add(WeatherActualFetch());
            blocContext.read<WeatherBloc>().add(WeekWeatherFetch());
          },
          child: SingleChildScrollView(
            child: Container(
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
                        '${weatherState.weatherModel?.sunrise?.hour.toString().padLeft(2, '0')}:${weatherState.weatherModel?.sunrise?.minute.toString().padLeft(2, '0')}',
                    sunset:
                        '${weatherState.weatherModel?.sunset?.hour.toString().padLeft(2, '0')}:${weatherState.weatherModel?.sunset?.minute.toString().padLeft(2, '0')}',
                    humidity: weatherState.weatherModel?.humidity ?? 0,
                  ),
                  if (dayWeathers.isNotEmpty) ...{
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: const Text(
                              "Ajourd'hui",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                for (Weather weather in dayWeathers) ...{
                                  HourWeatherData(
                                    weatherTemperature:
                                        weather.temperatureActual,
                                    weatherHour:
                                        '${weather.weatherDate.hour.toString().padLeft(2, '0')}:${weather.weatherDate.minute.toString().padLeft(2, '0')}',
                                    weatherIcon: weather.icon,
                                  ),
                                },
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  },
                  if (allWeathersExpectTodaysWeather.isNotEmpty) ...{
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            alignment: WrapAlignment.spaceEvenly,
                            children: [
                              const SizedBox(width: 10),
                              for (Weather weather
                                  in allWeathersExpectTodaysWeather) ...{
                                if (weather.weatherDate.hour == 0) ...{
                                  Container(
                                    margin: const EdgeInsets.all(20),
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      '${weather.weatherDate.day.toString().padLeft(2, '0')}/${weather.weatherDate.month.toString().padLeft(2, '0')}/${weather.weatherDate.year.toString()}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                },
                                HourWeatherData(
                                  weatherTemperature: weather.temperatureActual,
                                  weatherHour:
                                      '${weather.weatherDate.hour.toString().padLeft(2, '0')}:${weather.weatherDate.minute.toString().padLeft(2, '0')}',
                                  weatherIcon: weather.icon,
                                ),
                              },
                              const SizedBox(width: 10),
                            ],
                          ),
                        ],
                      ),
                    ),
                  },
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
