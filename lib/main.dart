import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/views/weather/weather_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        // Weather Bloc Provider
        BlocProvider<WeatherBloc>(
          create: (context) => WeatherBloc(weatherService: WeatherService()),
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
