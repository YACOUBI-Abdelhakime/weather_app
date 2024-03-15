import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/bloc/location/location_bloc.dart';
import 'package:weather_app/models/enums/event_status.dart';

class AddCityScreen extends StatefulWidget {
  const AddCityScreen({super.key});
  @override
  _AddCityScreenState createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {
  TextEditingController _cityNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LocationBloc, LocationState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (BuildContext context, LocationState locationState) {
          if (locationState.status == EventStatus.error) {
            // Show a snackbar to inform the user that the city name is not found
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(locationState.errorMassage ?? 'Error'),
              ),
            );
          } else if (locationState.status == EventStatus.loaded) {
            // Go to the cities list page
            context.go('/citiesList');
          }
        },
        child: GestureDetector(
          onTap: () {
            // Unfocus the text field when the user taps on the screen
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
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
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 70,
                      child: Row(
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
                          // Add text field to enter city name (the style i want to be the same as the search bar)
                          Expanded(
                            child: TextField(
                              controller: _cityNameController,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              cursorColor: Colors.white,
                              decoration: const InputDecoration(
                                hintText: 'Rechercher',
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(219, 255, 255, 255)),
                                border: InputBorder.none,
                              ),
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
                              if (_cityNameController.text.isNotEmpty) {
                                // Add event to check if the city exists
                                context.read<LocationBloc>().add(
                                    CheckCityIfExists(
                                        cityName: _cityNameController.text));
                                // Unfocus the text field when the user taps on the screen
                                FocusScope.of(context).unfocus();
                              } else {
                                // Show a snackbar to inform the user that the city name is empty
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Entrez un nom de ville'),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Entrez un nom de ville',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
