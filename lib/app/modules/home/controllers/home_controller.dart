import 'package:get/get.dart';
import 'package:weather/app/data/providers/location_provider.dart';

class HomeController extends GetxController {
  String myposition = "";
  final locationProvider = Get.put(LocationProvider());
  @override
  Future<void> onInit() async {
    super.onInit();
    myposition = await getPosition();
  }

  Future<String> getPosition() async {
    print('get position');
    var position = await locationProvider.getLocation();
    if (position != null) {
      print(position.toJson());
      return position.toJson().toString();
    }
    print("Position is null");
    return "Position is null";
  }
}