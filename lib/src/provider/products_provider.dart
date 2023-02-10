import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uber_demo_udemy/src/environment/environment.dart';
import 'package:uber_demo_udemy/src/models/products.dart';
import 'package:http/http.dart' as http;
import 'package:uber_demo_udemy/src/models/user.dart';
import 'package:path/path.dart';

class ProductsProvider extends GetConnect {
  String url = Environment.API_URL + "api/products";

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<Stream> createProducts(Products products, List<File> images) async {
    Uri uri = Uri.http("10.0.2.2:3000", "/api/products/create");

    final request = http.MultipartRequest('POST', uri);

    request.headers['Authorization'] = userSession.sessionToken ?? '';

    for (var i = 0; i < images.length; i++) {
      request.files.add(http.MultipartFile(
          'image',
          http.ByteStream(images[i].openRead().cast()),
          await images[i].length(),
          filename: basename(images[i].path)));
    }

    request.fields['products'] = json.encode(products);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<List<Products>> findByCategory(String idCategory) async {
    Response response = await get('$url/findByCategory/$idCategory', headers: {
      'Content-Type': 'application/json',
      'Authorization': userSession.sessionToken ?? ''
    }); //Esperar hasta que el servidor nos retorne la respuesta

    if (response.statusCode == 401) {
      Get.snackbar("Error en la peticion",
          "Tu usuario no tiene permitido leer esta informacion");
      return [];
    }
    List<Products> products = Products.fromJsonList(response.body);

    return products;
  }
}
