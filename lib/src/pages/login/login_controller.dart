import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uber_demo_udemy/src/models/response_api.dart';
import 'package:uber_demo_udemy/src/provider/users_provider.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void goToRegisterPage() {
    Get.toNamed('/register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    print("Email ${email}");

    if (isValidForm(email, password)) {
      ResponseApi responseApi = await usersProvider.login(email, password);

      print('Response Api: ${responseApi.toJson()}');

      if (responseApi.success == true) {
        GetStorage()
            .write('user', responseApi.data); //Datos del usuario en Sesion
        goToRolesPage();
      } else {
        Get.snackbar('Login fallido', responseApi.message ?? '');
      }
    }
  }

  void goToHomePage() {
    Get.offNamedUntil('/home', (route) => false);
  }

  void goToRolesPage() {
    Get.offNamedUntil('/roles', (route) => false);
  }

  bool isValidForm(String email, String password) {
    if (email.isEmpty) {
      Get.snackbar('Formulario no es valido', 'Debes ingresar el Email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Formulario no valido", "El email no es valido");

      return false;
    }

    if (password.isEmpty) {
      Get.snackbar(
          'Formulario no valido', 'Debes llenar los campos de contraseña');
      return false;
    }
    return true;
  }
}
