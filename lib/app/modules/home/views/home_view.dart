import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/app/modules/home/views/templates/row_item.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  @override
  final controller = Get.put(HomeController());

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
              RowItem(
                icon: Icons.location_on,
                text: location.value.city.toString(),
              ),
              const SizedBox(height: 32),
              RowItem(
                icon: Icons.wb_sunny,
                text:
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
