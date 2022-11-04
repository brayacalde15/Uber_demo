import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uber_demo_udemy/src/models/rol.dart';
import 'package:uber_demo_udemy/src/pages/roles/roles_controller.dart';

class RolesPage extends StatelessWidget {
  RolesController rolesCon = Get.put(RolesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Seleccionar Rol',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.17),
        
        child: ListView(
            children: rolesCon.user.roles != null
                ? rolesCon.user.roles!.map((Rol rol) {
                    return _cardRol(rol);
                  }).toList()
                : []),
      ),
    );
  }

  Widget _cardRol(Rol rol) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 15),
          height: 100,
          child: FadeInImage(
            image: NetworkImage(rol.image!),
            fit: BoxFit.contain,
            fadeInDuration: Duration(milliseconds: 50),
            placeholder: AssetImage('assets/img/delivery.png'),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 15),
          child: Text(rol.name ?? '',style: TextStyle(
            fontSize: 16,
            color: Colors.black
          ),),
        )
      ],
    );
  }
}
