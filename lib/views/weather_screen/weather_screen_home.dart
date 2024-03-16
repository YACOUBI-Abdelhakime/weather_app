import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/bloc/location/location_bloc.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/views/weather_screen/components/additional_weather_data.dart';
import 'package:weather_app/views/weather_screen/components/hour_weather_data.dart';
import 'package:weather_app/views/weather_screen/components/principal_weather_data.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    // Check if the location has been set => fetch the weather of this location
    // if not, fetch the weather of current location
    String? cityName = context.read<LocationBloc>().state.cityName;
    double? latitude = context.read<LocationBloc>().state.latitude;
    double? longitude = context.read<LocationBloc>().state.longitude;
    if (cityName == null && (latitude == null || longitude == null)) {
      context.read<LocationBloc>().add(LocationGetCurrent());
    } else {
      context.read<WeatherBloc>().add(WeatherActualFetch());
      context.read<WeatherBloc>().add(WeekWeatherFetch());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
        builder: (BuildContext blocContext, WeatherState weatherState) {
      List<Weather> dayWeathers = weatherState.getDayWeathers();
      List<Weather> allWeathersExpectTodaysWeather =
          weatherState.getAllWeathersExpectTodaysWeather();

      return Scaffold(
        appBar: AppBar(
          // Icon button to refresh the weather data
          leading: IconButton(
            icon: const Icon(
              Icons.refresh_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              context.read<WeatherBloc>().add(WeatherActualFetch());
              context.read<WeatherBloc>().add(WeekWeatherFetch());
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
            IconButton(
              padding: const EdgeInsets.only(right: 10),
              icon: const Icon(
                Icons.add_home_work_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                context.go('/citiesList');
              },
            )
          ],
        ),
        body: BlocListener<LocationBloc, LocationState>(
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
                    Colors.blue,
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
