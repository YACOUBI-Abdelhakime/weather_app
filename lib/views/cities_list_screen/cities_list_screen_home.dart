import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/bloc/location/location_bloc.dart';
import 'package:weather_app/views/cities_list_screen/components/city_card.dart';

class CitiesListScreen extends StatefulWidget {
  const CitiesListScreen({super.key});
  @override
  _CitiesListScreenState createState() => _CitiesListScreenState();
}

class _CitiesListScreenState extends State<CitiesListScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get selected cities if not already loaded
    if (context.read<LocationBloc>().state.selectedCities == null) {
      context.read<LocationBloc>().add(LocationGetSelectedCities());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (BuildContext context, LocationState locationState) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Screen header
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Button to go back to the previous page
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            context.go("/");
                          },
                        ),
                        // Screen title
                        const Text(
                          'Villes',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        // Button to add the city
                        IconButton(
                          icon: const Icon(
                            Icons.add_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            // Go to the add city page
                            context.go('/addCity');
                          },
                        ),
                      ],
                    ),
                  ),
                  // Screen body
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (String cityName
                              in locationState.selectedCities ?? []) ...{
                            CityCard(
                              cityName: cityName,
                            ),
                          }
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
