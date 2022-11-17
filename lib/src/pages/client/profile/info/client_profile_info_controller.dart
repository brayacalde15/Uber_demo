import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uber_demo_udemy/src/models/user.dart';

class ClientProfileInfoController extends GetxController {
  User user = User.fromJson(GetStorage().read('user'));

  void logOut() {
    GetStorage().remove('user');
    Get.offNamedUntil(
        '/', (route) => false); //Eliminar el historial de pantalla
  }

  void goToProfileUpdatePage() {
    Get.toNamed('/client/profile/update');
  }
}
