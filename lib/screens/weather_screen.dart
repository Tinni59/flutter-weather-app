import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 189, 145, 233),
      appBar: AppBar(
        title: const Text('Погода'),
        backgroundColor: const Color(0xFF3C1361),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.wb_sunny, size: 130, color: Colors.amber),
            SizedBox(height: 20),
            Text(
              'Караганда',
              style: TextStyle(fontSize: 26, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Солнечно!',
              style: TextStyle(fontSize: 20, color: Colors.white70),
            ),
            SizedBox(height: 10),
            Text('+1°C', style: TextStyle(fontSize: 42, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
