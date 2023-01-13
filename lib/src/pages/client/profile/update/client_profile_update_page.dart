import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber_demo_udemy/src/pages/client/profile/update/client_profile_update_controller.dart';

class ClientProfileUpdatePage extends StatelessWidget {
  ClientProfileUpdatecontroller con = Get.put(ClientProfileUpdatecontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _backgroundCover(context),
        _boxForm(context),
        _buttonBack(),
        _imageUser(context)
      ],
    ));
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.45,
      color: Colors.amber,
      alignment: Alignment.center,
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.43,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.32, left: 10, right: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54, blurRadius: 15, offset: Offset(0, 0.075))
          ]),
      child: SingleChildScrollView(
        child: Column(children: [
          _texYourInfo(),
          _textFieldName(),
          _textFieldLastName(),
          _textFieldPhone(),
          _buttomUpdate(context)
        ]),
      ),
    );
  }

  Widget _buttonBack() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
          controller: con.nameController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              hintText: '',
              prefixIcon: Icon(
                Icons.person,
                size: 30,
              ))),
    );
  }

  Widget _textFieldLastName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
          controller: con.lastNameController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              hintText: '',
              prefixIcon: Icon(
                Icons.person_outline,
                size: 30,
              ))),
    );
  }

  Widget _textFieldPhone() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: TextField(
            controller: con.phoneController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '',
              prefixIcon: Icon(
                Icons.phone,
                size: 30,
              ),
            )));
  }

  Widget _buttomUpdate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      child: ElevatedButton(
          onPressed: () => con.updateInfo(context),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)),
          child: Text(
            "Actualizar",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )),
    );
  }

  Widget _imageUser(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        alignment: Alignment.topCenter,
        child: GestureDetector(
            onTap: () => con.showAlertDialog(context),
            child: GetBuilder<ClientProfileUpdatecontroller>(
              builder: (value) => CircleAvatar(
                backgroundImage: con.imageFile != null
                    ? FileImage(con.imageFile!)
                    : con.user.image != null
                        ? NetworkImage(con.user.image!)
                        : AssetImage("assets/img/delivery.png")
                            as ImageProvider,
                radius: 80,
                backgroundColor: Colors.white,
              ),
            )),
      ),
    );
  }

  Widget _texYourInfo() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 30),
      child: const Text("INGRESA ESTA INFORMACIÓN",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
