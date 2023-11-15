import 'package:get/get.dart';
import 'package:weather/app/data/providers/location_provider.dart';

class HomeController extends GetxController {
  Rx<String> myposition = RxString('not initialized');
  final _locationProvider = Get.put(LocationProvider());
  @override
  Future<void> onInit() async {
    super.onInit();
    //on met une attente de 2 secondes pour voir le chargement
    await Future.delayed(const Duration(seconds: 3));
    await getPosition();
  }

  Future<String> getPosition({bool fake = false}) async {
    if (fake) {
      print('get fake position');
      myposition.value =
          '{"status":"success","country":"France","countryCode":"FR","region":"IDF","regionName":"Île-de-France","city":"Paris","zip":"75001","lat":48.8323,"lon":2.4075,"timezone":"Europe/Paris","isp":"SCALEWAY","org":"ONLINE","as":"AS12876 SCALEWAY S.A.S.","query":"51.159.148.219"}';
    } else {
      print('get position');
      var position = await _locationProvider.getLocation();
      if (position != null) {
        print(position.toJson());
        myposition.value = position.toJson().toString();
      } else {
        print("Position is null");
        myposition.value = "Position is null";
      }
    }
    return myposition.value;
  }
}
