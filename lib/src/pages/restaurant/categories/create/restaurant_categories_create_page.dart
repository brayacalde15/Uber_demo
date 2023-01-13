import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:uber_demo_udemy/src/pages/restaurant/categories/create/restaurant_categories_create_controller.dart';

class RestaurantCategoriesCreatePage extends StatelessWidget {
  RestaurantCategoriesCreateController con =
      Get.put(RestaurantCategoriesCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _backgroundCover(context),
        _boxForm(context),
        _textNewCategory(context)
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
          _textFieldNameCategory(),
          _textFieldDescription(),
          _buttomCreateCategory(context)
        ]),
      ),
    );
  }

  Widget _textFieldNameCategory() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
          controller: con.nameController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
              hintText: 'Nombre de la categoria',
              prefixIcon: Icon(
                Icons.category,
                size: 30,
              ))),
    );
  }

  Widget _textFieldDescription() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: TextField(
            controller: con.descriptionController,
            keyboardType: TextInputType.text,
            maxLines: 3,
            decoration: InputDecoration(
                hintText: 'Descripcion de la categoria',
                prefixIcon: Container(
                  margin: EdgeInsets.only(bottom: 40),
                  child: Icon(Icons.description),
                ))));
  }

  Widget _buttomCreateCategory(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      child: ElevatedButton(
          onPressed: () {
            con.createCategory();
          },
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)),
          child: Text(
            "Crear Categoria",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )),
    );
  }

  Widget _textNewCategory(BuildContext context) {
    return SafeArea(
      child: Container(
          margin: EdgeInsets.only(top: 60),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Icon(
                Icons.category,
                size: 100,
              ),
              Text(
                "Nueva Categoria",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ],
          )),
    );
  }

  Widget _texYourInfo() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 30),
      child: const Text("INGRESA ESTA INFORMACIÓN",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)),
    );
  }
}
