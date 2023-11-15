import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  @override
  final controller = Get.put(HomeController());

  final ligne = [
    {'icon': Icons.location_city_outlined, 'text': "Your location is TODO"},
    {'icon': Icons.thermostat_outlined, 'text': "The temperature is TODO"},
    {'icon': Icons.info_outline, 'text': "You should TODO"},
  ];

  @override
  Widget build(BuildContext context) {
    final location = controller.location;
    final meteo = controller.meteo;
    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var item in ligne)
                buildLocationRow(
                  item['icon'] as IconData,
                  item['text'] as String,
                ),
              const SizedBox(height: 32),
              Text(
                location.value.city
                    .toString(), // Access the city property directly
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 32),
              Text(
                meteo.value.hourly?.temperature2m?.first.toString() ?? '0',
              ),
              ElevatedButton(
                onPressed: () {
                  controller.getPosition(fake: true);
                  controller.getMeteo();
                },
                child: const Text('Relancer la localisation'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLocationRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          icon,
          size: 32,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
