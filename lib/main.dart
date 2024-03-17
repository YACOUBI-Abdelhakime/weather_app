import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/bloc/location/location_bloc.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/services/local_storage_service.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/views/add_city_screen/add_city_screen_home.dart';
import 'package:weather_app/views/cities_list_screen/cities_list_screen_home.dart';
import 'package:weather_app/views/weather_screen/weather_screen_home.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        // Location Bloc Provider
        BlocProvider<LocationBloc>(
          create: (context) => LocationBloc(
              locationService: LocationService(),
              localStorageService: LocalStorageService()),
        ),
        // Weather Bloc Provider
        BlocProvider<WeatherBloc>(
          create: (context) => WeatherBloc(
              locationBloc: context.read<LocationBloc>(),
              weatherService: WeatherService(),
              localStorageService: LocalStorageService()),
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
    return MaterialApp.router(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      routerConfig: GoRouter(
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return const WeatherScreen();
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'addCity',
                builder: (BuildContext context, GoRouterState state) {
                  return const AddCityScreen();
                },
              ),
              GoRoute(
                path: 'citiesList',
                builder: (BuildContext context, GoRouterState state) {
                  return const CitiesListScreen();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
