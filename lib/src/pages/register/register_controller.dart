import 'dart:convert';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:uber_demo_udemy/src/models/response_api.dart';
import 'package:uber_demo_udemy/src/models/user.dart';
import 'package:uber_demo_udemy/src/provider/users_provider.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  ImagePicker picker = ImagePicker();

  File? imageFile;

  void register(BuildContext context) async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (isValidForm(email, name, lastName, phone, password, confirmPassword)) {
      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Registrando datos.....');

      User user = User(
          email: email,
          name: name,
          lastname: lastName,
          phone: phone,
          password: password,
          confirmpassword: confirmPassword);

      Stream stream = await usersProvider.createUserWithImage(user, imageFile!);

      stream.listen((res) {

         progressDialog.close();

        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        if (responseApi.success == true) {
          GetStorage()
              .write('user', responseApi.data); //Datos del usuario en Sesion
          goToHomePage();
        } else {
          Get.snackbar('Registro fallido', responseApi.message ?? '');
        }
      });
    }
  }

  void goToHomePage() {
    Get.offNamedUntil('/home', (route) => false);
  }

  bool isValidForm(String email, String name, String lastName, String phone,
      String password, String confirmPassword) {
    if (email.isEmpty) {
      Get.snackbar('Formulario no es valido', '');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Formulario no valido", "El email no es valido");

      return false;
    }
    if (name.isEmpty) {
      Get.snackbar('Formulario no es valido', 'Debes ingresar tu nombre');
    }

    if (lastName.isEmpty) {
      Get.snackbar("Formulario no valido", 'Debes ingresar tu apellido');
    }
    if (phone.isEmpty) {
      Get.snackbar('Formulario no es valido', 'Ingrese el numero de telefono');
    }

    if (password.isEmpty) {
      Get.snackbar(
          'Formulario no valido', 'Debes llenar los campos de contraseña');
      return false;
    }

    if (confirmPassword.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes confirmar la contraseña');
    }
    if (password != confirmPassword) {
      Get.snackbar('Formulario no valido ', 'Las contraseñas no coinciden');
      return false;
    }
    if (imageFile == null) {
      Get.snackbar(
          'Formulario no valido ', 'Debes agregar una Imagen de perfil');
      return false;
    }

    return true;
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imageFile = File(image.path);
      update();
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery);
        },
        child: Text("Galeria", style: TextStyle(color: Colors.black)));

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera);
        },
        child: Text("Camara", style: TextStyle(color: Colors.black)));

    AlertDialog alertDialog = AlertDialog(
      title: Text("Selecciona una opcion"),
      actions: [galleryButton, cameraButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
