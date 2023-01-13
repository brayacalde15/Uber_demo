import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uber_demo_udemy/src/models/category.dart';
import 'package:uber_demo_udemy/src/models/response_api.dart';
import 'package:uber_demo_udemy/src/models/user.dart';

import '../environment/environment.dart';

class CategoriesProvider extends GetConnect {
  String url = Environment.API_URL + "api/categories";

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<ResponseApi> create(Category category) async {
    Response response = await post('$url/create', category.toJson(), headers: {
      'Content-Type': 'application/json',
      'Authorization': userSession.sessionToken ?? ''
    }); //Esperar hasta que el servidor nos retorne la respuesta

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}
