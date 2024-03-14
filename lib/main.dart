import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/location/location_bloc.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/views/weather/weather_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        // Location Bloc Provider
        BlocProvider<LocationBloc>(
          create: (context) => LocationBloc(locationService: LocationService()),
        ),
        // Weather Bloc Provider
        BlocProvider<WeatherBloc>(
          create: (context) => WeatherBloc(
              locationBloc: context.read<LocationBloc>(),
              weatherService: WeatherService()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const WeatherScreen(),
    );
  }
}
