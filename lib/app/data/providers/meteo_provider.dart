// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';

import '../models/meteo_model.dart';
import 'package:http/http.dart' as http;

class MeteoProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Meteo.fromJson(map);
      if (map is List) return map.map((item) => Meteo.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'https://api.open-meteo.com/v1/forecast';
  }

  Future<Meteo?> getMeteo(double? lat, double? lon) async {
    final queryParameters = {
      'latitude': '$lat',
      'longitude': '$lon',
      'current': 'temperature_2m,wind_speed_10m',
      'hourly': 'temperature_2m,relative_humidity_2m,wind_speed_10m',
    };
    final uri = Uri.parse(httpClient.baseUrl!)
        .replace(queryParameters: queryParameters);
    print(uri.toString());
    final response = await http.get(uri);
    return response.body.isNotEmpty
        ? Meteo.fromJson(jsonDecode(response.body))
        : null;
  }

  Future<Response<Meteo>> postMeteo(Meteo meteo) async =>
      await post('meteo', meteo);
  Future<Response> deleteMeteo(int id) async => await delete('meteo/$id');
}
