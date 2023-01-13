import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:uber_demo_udemy/src/models/response_api.dart';
import 'package:uber_demo_udemy/src/models/user.dart';
import 'package:uber_demo_udemy/src/pages/client/profile/info/client_profile_info_controller.dart';

import '../../../../provider/users_provider.dart';

class ClientProfileUpdatecontroller extends GetxController {
  User user = User.fromJson(GetStorage().read('user'));

  TextEditingController nameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  ImagePicker picker = ImagePicker();

  File? imageFile;

  UsersProvider usersProvider = UsersProvider();

  ClientProfileInfoController infoController = Get.find();

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

  void updateInfo(BuildContext context) async {
    User localUser = User.fromJson(GetStorage().read('user'));

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
          id: localUser.id,
          name: name,
          lastname: lastName,
          phone: phone,
          sessionToken: localUser.sessionToken);

      if (imageFile == null) {
        ResponseApi responseApi =
            await usersProvider.updateWithOutImage(myUser);

        print("Response Api UpdateWithOutImage :${responseApi.data}");

        progressDialog.close();

        if (responseApi.success == true) {
          GetStorage().write('user', responseApi.data);

          infoController.user.value =
              User.fromJson(GetStorage().read('user') ?? {});

          print('Response Api Update : ${responseApi.data}');
        }
      } else {
        Stream stream = await usersProvider.updateWithImage(myUser, imageFile!);

        stream.listen((res) {
          progressDialog.close();

          ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

          print('Response Api Update : ${responseApi.data}');

          if (responseApi.success == true) {
            GetStorage().write('user', responseApi.data);
            infoController.user.value =
                User.fromJson(GetStorage().read('user') ?? {});
          } else {
            Get.snackbar('Actualizacion  fallido', responseApi.message ?? '');
          }
        });
      }
    }
  }
}
