import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';
import 'package:get/get_connect.dart';
import 'package:get/get.dart';
import 'package:uber_demo_udemy/src/environment/environment.dart';
import 'package:uber_demo_udemy/src/models/response_api.dart';
import 'package:uber_demo_udemy/src/models/user.dart';
import 'package:http/http.dart' as http;

class UsersProvider extends GetConnect {
  String url = Environment.API_URL + "api/users";

  Future<Response> create(User user) async {
    Response response = await post('$url/create', user.toJson(), headers: {
      'Content-Type': 'application/json'
    }); //Esperar hasta que el servidor nos retorne la respuesta

    return response;
  }

  Future<Stream> createUserWithImage(User user, File image) async {
    Uri uri = Uri.http("10.0.2.2:3000","/api/users/createWithImage");

    final request = http.MultipartRequest('POST', uri);

    request.files.add(http.MultipartFile(

   'image',
    http.ByteStream(image.openRead().cast()),
    await image.length(),
    filename: basename(image.path)));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }
  /**
   * GET X
   

  Future<ResponseApi> createUserWithImageGetX(User user, File image) async {
    FormData form = FormData({
      'image': MultipartFile(image, filename: basename(image.path)),
      'user': json.encode(user)
    });
    Response response = await post('$url/createWithImage', form);
    if (response.body == null) {
      Get.snackbar('Error en la Petición', 'Nose puede crear el usuario');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return ResponseApi();
  }
  **/

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post(
        '$url/login', {'email': email, 'password': password},
        headers: {'Content-Type': 'application/json'});

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo ejecutar la peticion');

      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}
