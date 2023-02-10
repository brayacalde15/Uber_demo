import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uber_demo_udemy/src/models/category.dart';
import 'package:uber_demo_udemy/src/models/products.dart';
import 'package:uber_demo_udemy/src/provider/categories_provider.dart';
import 'package:uber_demo_udemy/src/provider/products_provider.dart';

class ClientProductsListController extends GetxController {
  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();

  List<Category> listCategories = <Category>[].obs;

  ClientProductsListController() {
    getCategories();
  }

  void getCategories() async {
    var result = await categoriesProvider.getAll();
    listCategories.addAll(result);
  }

  Future<List<Products>> getProducts(String idCategory) async {
    return await productsProvider.findByCategory(idCategory);
  }
}
