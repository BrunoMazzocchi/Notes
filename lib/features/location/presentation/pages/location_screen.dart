import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:notes/features/location/presentation/bloc/historic_location/historic_location_bloc.dart';
import 'package:notes/features/location/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:latlong2/latlong.dart'; // Assuming you need this for the FlutterMap

class LocationScreen extends StatefulWidget {
  static const String routeName = '/location-screen';
  static const String routePath = '/location-screen';

  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showHistoricLocationsBottomSheet(context);
        },
        child: const Icon(Icons.history),
      ),
      appBar: AppBar(
        title: const Text('Location'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) {
                if (state is LocationLoaded) {
                  context.read<HistoricLocationBloc>().add(
                        SaveHistoricLocationEvent(
                          state.position,
                          action: () {
                            context.read<HistoricLocationBloc>().add(
                                  GetHistoricLocationEvent(),
                                );
                          },
                        ),
                      );

                  return FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(
                          state.position.latitude, state.position.longitude),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: LatLng(state.position.latitude,
                                state.position.longitude),
                            child: const Icon(Icons.location_pin,
                                color: Colors.red, size: 40),
                          ),
                        ],
                      ),
                    ],
                  );
                }

                if (state is LocationError) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showHistoricLocationsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return BlocBuilder<HistoricLocationBloc, HistoricLocationState>(
          builder: (context, state) {
            if (state is HistoricLocationLoaded) {
              return Container(
                height: 50.h,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Historic Locations',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.locationList.length,
                        itemBuilder: (context, index) {
                          final location = state.locationList[index];
                          final isFirstOne = index == 0;
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isFirstOne
                                  ? Colors.redAccent
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Latitude: ${location.latitude}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('Longitude: ${location.longitude}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Icon(
                                  Icons.location_on,
                                  color:
                                      isFirstOne ? Colors.white : Colors.black54,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is HistoricLocationError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(state.message),
                ),
              );
            }

            return const Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            );
          },
        );
      },
    );
  }
}
