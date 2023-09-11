import 'package:flutter/material.dart';
import 'package:untitled/animated_radial_menu.dart';
import 'package:untitled/targetScreen.dart';

void navigateTo(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const TargetScreen(),
    ),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Radial Speed Dial"), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RadialMenu(
            children: [
              RadialButton(
                icon: const Icon(Icons.ac_unit),
                backgroundColor: Colors.teal,
                onPressed: () => navigateTo(context),
              ),
              RadialButton(
                icon: const Icon(Icons.camera_alt),
                backgroundColor: Colors.green,
                onPressed: () => navigateTo(context),
              ),
              RadialButton(
                icon: const Icon(Icons.map),
                backgroundColor: Colors.orange,
                onPressed: () => navigateTo(context),
              ),
              RadialButton(
                icon: const Icon(Icons.access_alarm),
                backgroundColor: Colors.indigo,
                onPressed: () => navigateTo(context),
              ),
              RadialButton(
                icon: const Icon(Icons.watch),
                backgroundColor: Colors.pink,
                onPressed: () => navigateTo(context),
              ),
              RadialButton(
                icon: const Icon(Icons.settings),
                backgroundColor: Colors.blue,
                onPressed: () => navigateTo(context),
              ),
              RadialButton(
                icon: const Icon(Icons.mail_outline),
                backgroundColor: Colors.yellow,
                onPressed: () => navigateTo(context),
              ),
              RadialButton(
                icon: const Icon(Icons.logout),
                backgroundColor: Colors.red,
                onPressed: () => navigateTo(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
