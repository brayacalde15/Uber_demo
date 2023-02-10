import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:uber_demo_udemy/src/models/category.dart';
import 'package:uber_demo_udemy/src/pages/restaurant/categories/create/restaurant_categories_create_controller.dart';
import 'package:uber_demo_udemy/src/pages/restaurant/products/create/restaurant_products_create_controller.dart';

class RestaurantProductsCreatePage extends StatelessWidget {
  RestaurantproductsCreateController con =
      Get.put(RestaurantproductsCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => Stack(
              children: [
                _backgroundCover(context),
                _boxForm(context),
                _textNewCategory(context)
              ],
            )));
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
      height: MediaQuery.of(context).size.height * 1.70,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.2, left: 10, right: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54, blurRadius: 15, offset: Offset(0, 0.075))
          ]),
      child: SingleChildScrollView(
        child: Column(children: [
          _texYourInfo(),
          _textFieldNameProducts(),
          _textFieldDescriptionProducts(),
          _textFieldPriceProducts(),
          _dropDownCategories(con.categories),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GetBuilder<RestaurantproductsCreateController>(
                    builder: (Value) => _cardImage(context, con.imageFile1, 1)),
                GetBuilder<RestaurantproductsCreateController>(
                  builder: (Value) => _cardImage(context, con.imageFile2, 2),
                ),
                GetBuilder<RestaurantproductsCreateController>(
                    builder: (Value) => _cardImage(context, con.imageFile3, 3))
              ],
            ),
          ),
          _buttomCreateProducts(context)
        ]),
      ),
    );
  }

  Widget _dropDownCategories(List<Category> categories) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: DropdownButton(
        underline: Container(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.amber,
          ),
        ),
        elevation: 3,
        isExpanded: true,
        hint: Text(
          "Seleccionar Categoria",
          style: TextStyle(fontSize: 12),
        ),
        items: _dropDownItems(categories),
        value: con.idCategory.value == '' ? null : con.idCategory.value,
        onChanged: (option) {
          print('Opcion seleccionada ${option}');
          con.idCategory.value = option.toString();
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItems(List<Category> categories) {
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((category) {
      list.add(DropdownMenuItem(
        child: Text(category.name ?? ''),
        value: category.id,
      ));
    });

    return list;
  }

  Widget _cardImage(BuildContext context, File? imageFile, int numberFile) {
    return GestureDetector(
        onTap: () => con.showAlertDialog(context, numberFile),
        child: Card(
          elevation: 5,
          child: Container(
              height: 90,
              width: MediaQuery.of(context).size.width * 0.25,
              child: imageFile != null
                  ? Image.file(
                      imageFile,
                      fit: BoxFit.cover,
                    )
                  : Image(image: AssetImage('assets/img/delivery.png'))),
        ));
  }

  Widget _textFieldNameProducts() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
          controller: con.nameController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
              hintText: 'Nombre del Producto',
              prefixIcon: Icon(
                Icons.apple_outlined,
                size: 30,
              ))),
    );
  }

  Widget _textFieldPriceProducts() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: TextField(
          controller: con.priceController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              hintText: 'Precio del Producto: ',
              prefixIcon: Icon(
                Icons.attach_money_outlined,
                size: 30,
              ))),
    );
  }

  Widget _textFieldDescriptionProducts() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: TextField(
            controller: con.descriptionController,
            keyboardType: TextInputType.text,
            maxLines: 2,
            decoration: InputDecoration(
                hintText: 'Descripcion del Producto',
                prefixIcon: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Icon(Icons.description),
                ))));
  }

  Widget _buttomCreateProducts(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: ElevatedButton(
          onPressed: () {
            con.createProducts(context);
          },
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10)),
          child: Text(
            "Crear Producto",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )),
    );
  }

  Widget _textNewCategory(BuildContext context) {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.only(top: 60),
      alignment: Alignment.topCenter,
      child: Text(
        "Nuevo Producto",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ),
    ));
  }

  Widget _texYourInfo() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: const Text("INGRESA ESTA INFORMACIÓN",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)),
    );
  }
}
