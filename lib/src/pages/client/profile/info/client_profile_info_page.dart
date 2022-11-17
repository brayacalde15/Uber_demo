import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber_demo_udemy/main.dart';
import 'package:uber_demo_udemy/src/pages/client/profile/info/client_profile_info_controller.dart';
import 'package:uber_demo_udemy/src/pages/client/profile/update/client_profile_update_page.dart';

class ClientProfileInfoPage extends StatelessWidget {
  ClientProfileInfoController con = Get.put(ClientProfileInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _backgroundCover(context),
        _boxForm(context),
        _imageUser(context),
        _buttonSignOut()
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
      height: MediaQuery.of(context).size.height * 0.4,
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
          _textName(),
          _textEmail(),
          _textPhone(),
          _buttomUpdate(context),
        ]),
      ),
    );
  }

  Widget _buttonSignOut() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(right: 5, top: 10),
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: () => con.logOut(),
          icon: const Icon(
            Icons.power_settings_new_sharp,
            size: 30,
          ),
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buttomUpdate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      child: ElevatedButton(
          onPressed: () => con.goToProfileUpdatePage(),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10)),
          child: const Text(
            "Actualizar Datos",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )),
    );
  }

  Widget _imageUser(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        alignment: Alignment.topCenter,
        child: CircleAvatar(
          backgroundImage: con.user.image != null
              ? NetworkImage(con.user.image!)
              : AssetImage('assets/img/delivery.png') as ImageProvider,
          radius: 80,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget _textName() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: ListTile(
        leading: Icon(Icons.person_rounded),
        title: Text("${con.user.name ?? ''} ${con.user.lastname ?? ''}",
            style: TextStyle(
              color: Colors.black,
            )),
        subtitle: Text("Nombre del Usuario"),
      ),
    );
  }

  Widget _textEmail() {
    return ListTile(
      leading: Icon(Icons.email),
      title: Text('${con.user.email}' ?? ''),
      subtitle: Text('Email'),
    );
  }

  Widget _textPhone() {
    return ListTile(
      leading: Icon(Icons.phone_android_outlined),
      title: Text('${con.user.phone}' ?? ''),
      subtitle: Text('Telefono'),
    );
  }
}
