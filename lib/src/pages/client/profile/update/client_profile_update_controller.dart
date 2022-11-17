import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:uber_demo_udemy/src/models/user.dart';

import '../../../../provider/users_provider.dart';

class ClientProfileUpdatecontroller extends GetxController {
  User user = User.fromJson(GetStorage().read('user'));

  TextEditingController nameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  ImagePicker picker = ImagePicker();

  File? imageFile;

  UsersProvider usersProvider = UsersProvider();

  ClientProfileUpdatecontroller() {
    nameController.text = user.name ?? '';
    lastNameController.text = user.lastname ?? '';
    phoneController.text = user.phone ?? '';
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

  bool isValidForm(String name, String lastName, String phone) {
    if (name.isEmpty) {
      Get.snackbar('Formulario no es valido', 'Debes ingresar tu nombre');
    }

    if (lastName.isEmpty) {
      Get.snackbar("Formulario no valido", 'Debes ingresar tu apellido');
    }
    if (phone.isEmpty) {
      Get.snackbar('Formulario no es valido', 'Ingrese el numero de telefono');
    }
    return true;
  }

  void register(BuildContext context) async {
    String name = nameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text.trim();

    if (isValidForm(
      name,
      lastName,
      phone,
    )) {
      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Actualizando Datos.....');

      User myUser = User(
        id: user.id,
        name: name,
        lastname: lastName,
        phone: phone,
      );
    }
  }
}
