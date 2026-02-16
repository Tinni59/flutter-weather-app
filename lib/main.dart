import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _controller = TextEditingController();
  String city = "Karaganda";
  String temperature = "";
  String condition = "";
  String iconUrl = "";
  bool loading = false;

  final String apiKey = "c29eff0ef2914174907112338261602";

  Future<void> getWeather() async {
    setState(() {
      loading = true;
    });

    final url = Uri.parse(
      "https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city&lang=ru",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        temperature = "${data['current']['temp_c']}°C";
        condition = data['current']['condition']['text'];
        iconUrl = "https:${data['current']['condition']['icon']}";
        loading = false;
      });
    } else {
      setState(() {
        temperature = "Ошибка";
        condition = "Город не найден";
        iconUrl = "";
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Погода"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              city,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            if (loading)
              const CircularProgressIndicator()
            else ...[
              if (iconUrl.isNotEmpty) Image.network(iconUrl, width: 80),
              const SizedBox(height: 10),
              Text(temperature, style: const TextStyle(fontSize: 40)),
              const SizedBox(height: 5),
              Text(condition, style: const TextStyle(fontSize: 18)),
            ],
            const SizedBox(height: 30),
            SizedBox(
              width: 250,
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Введите город",
                ),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  setState(() {
                    city = _controller.text;
                  });
                  getWeather();
                }
              },
              child: const Text("Узнать погоду"),
            ),
          ],
        ),
      ),
    );
  }
}
