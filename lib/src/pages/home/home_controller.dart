import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uber_demo_udemy/src/models/user.dart';

class HomeController extends GetxController{

  User userSesion = User.fromJson(GetStorage().read('user')??{});

  HomeController(){
    print('Usuario de sesion:${userSesion.toJson()}');
  }

  void logOut(){
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);//Eliminar el historial de pantalla
  }

}