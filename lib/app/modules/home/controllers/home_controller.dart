// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:weather/app/data/models/location_model.dart';
import 'package:weather/app/data/models/meteo_model.dart';
import 'package:weather/app/data/providers/location_provider.dart';
import 'package:weather/app/data/providers/meteo_provider.dart';

class HomeController extends GetxController {
  Rx<Location> location = Rx<Location>(Location());
  Rx<Meteo> meteo = Rx<Meteo>(Meteo());

  final _locationProvider = Get.put(LocationProvider());
  final _meteoProvider = Get.put(MeteoProvider());

  @override
  Future<void> onInit() async {
    super.onInit();
    //on met une attente de 2 secondes pour voir le chargement
    await Future.delayed(const Duration(seconds: 3));
    await getPosition();
    await getMeteo();
  }

  Future<void> getPosition({bool fake = false}) async {
    if (fake) {
      print('get fake position');
      location.value = Location.fromJson(jsonDecode(
          '{"status":"success","country":"France","countryCode":"FR","region":"IDF","regionName":"Île-de-France","city":"Paris","zip":"75001","lat":48.8323,"lon":2.4075,"timezone":"Europe/Paris","isp":"SCALEWAY","org":"ONLINE","as":"AS12876 SCALEWAY S.A.S.","query":"51.159.148.219"}'));
    } else {
      print('get position');
      var position = await _locationProvider.getLocation();
      if (position != null) {
        location.value = position;
      }
    }
    return;
  }

  Future<void> getMeteo() async {
    print('get meteo');
    if (location.value.lat != null && location.value.lon != null) {
      var temps =
          await _meteoProvider.getMeteo(location.value.lat, location.value.lon);
      meteo.value = temps!;
    }
  }
}
