import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/location/presentation/bloc/historic_location/historic_location_bloc.dart';
import 'package:notes/features/location/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
    return BlocListener<HistoricLocationBloc, HistoricLocationState>(
      listener: (context, state) {},
      child: Scaffold(
        bottomSheet: SizedBox(
          height: 10.h,
          child: BlocBuilder<HistoricLocationBloc, HistoricLocationState>(
            builder: (context, state) {
              if (state is HistoricLocationLoaded) {
                return ListView.builder(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.locationList.length,
                  itemBuilder: (context, index) {
                    final location = state.locationList[index];
                    // if the location is the last location saved,
                    // set a Color red 
                    final color = index == state.locationList.length - 1
                        ? Colors.red
                        : Colors.grey;
                    return Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Latitude: ${location.latitude}'),
                          Text('Longitude: ${location.longitude}'),
                        ],
                      ),
                    );
                  },
                );
              }

              if (state is HistoricLocationError) {
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
        appBar: AppBar(
          title: const Text('Location'),
        ),
        body: BlocListener<HistoricLocationBloc, HistoricLocationState>(
          listener: (context, state) {},
          child: BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              if (state is LocationLoaded) {
                context.read<HistoricLocationBloc>().add(
                      SaveHistoricLocationEvent(
                        state.position,
                        action: () {
                          context
                              .read<HistoricLocationBloc>()
                              .add(GetHistoricLocationEvent());
                        },
                      ),
                    );
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Latitude: ${state.position.latitude}'),
                      Text('Longitude: ${state.position.longitude}'),
                    ],
                  ),
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
      ),
    );
  }
}
