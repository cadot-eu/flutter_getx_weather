// ignore_for_file: avoid_print
import 'package:get/get.dart';

import '../models/location_model.dart';

class LocationProvider extends GetConnect {
  @override
  void onInit() {
    print('init locationprovider');
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Location.fromJson(map);
      if (map is List) {
        return map.map((item) => Location.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = 'http://ip-api.com/';
    getLocation();
  }

  Future<Location?> getLocation() async {
    final response = await get('/json');
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<Response<Location>> postLocation(Location location) async =>
      await post('location', location);
  Future<Response> deleteLocation(int id) async => await delete('location/$id');
}
