import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 156, 117, 196),
      appBar: AppBar(
        title: const Text('Главная'),
        backgroundColor: const Color(0xFF3C1361),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/weather'),
              child: const Text('Погода)'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                NotificationService.show(
                  'Напоминание',
                  'Пора сделать перерыв)',
                );
              },
              child: const Text('Уведомление)'),
            ),
          ],
        ),
      ),
    );
  }
}
