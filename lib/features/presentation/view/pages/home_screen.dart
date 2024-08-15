import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/features/location/presentation/pages/location_screen.dart';
import 'package:notes/features/notes/presentation/views/notes_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';
  static const String routePath = '/';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tiles App'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
        ),
        child: Column(
          children: [
            _customTile(
              'Notes',
              () {
                context.push(NotesScreen.routePath);
              },
            ),

            _customTile(
              'Location',
              () {
                context.push(LocationScreen.routePath);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _customTile(String title, void Function()? onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: ListTile(
          title: Text(title),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
