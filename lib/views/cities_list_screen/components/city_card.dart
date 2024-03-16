import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/bloc/location/location_bloc.dart';

class CityCard extends StatelessWidget {
  final String cityName;
  const CityCard({
    super.key,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Update the city name location
        context.read<LocationBloc>().add(LocationUpdate(cityName: cityName));
        // Go to the weather screen
        context.go('/');
      },
      child: Container(
        width: double.infinity,
        height: 80,
        margin: const EdgeInsets.all(10),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
              ),
              child: const Icon(
                Icons.location_city_outlined,
                size: 45,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  right: 10,
                ),
                child: Text(
                  cityName,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
            IconButton(
              padding: const EdgeInsets.all(10),
              onPressed: () {
                // Delete the city name from the selected cities list
                context
                    .read<LocationBloc>()
                    .add(LocationSelectedCityNameDelete(cityName: cityName));
              },
              icon: const Icon(
                Icons.delete_outline,
                size: 30,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
