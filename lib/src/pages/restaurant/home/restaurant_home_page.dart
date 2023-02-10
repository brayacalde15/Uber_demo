import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:uber_demo_udemy/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:uber_demo_udemy/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:uber_demo_udemy/src/pages/register/register_page.dart';
import 'package:uber_demo_udemy/src/pages/restaurant/categories/create/restaurant_categories_create_page.dart';
import 'package:uber_demo_udemy/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:uber_demo_udemy/src/pages/restaurant/products/create/restaurant_products_create_page.dart';
import 'package:uber_demo_udemy/src/utils/custom_animated_bottom_bar.dart';

import 'restaurant_home_controller.dart';

class RestaurantHomePage extends StatelessWidget {
  RestaurantHomeController con = Get.put(RestaurantHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _bottomBar(),
        body: Obx((() => IndexedStack(
              index: con.indexTab.value,
              children: [
                RestaurantOrdersListPage(),
                RestaurantCategoriesCreatePage(),
                RestaurantProductsCreatePage(),
                ClientProfileInfoPage()
              ],
            ))));
  }

  Widget _bottomBar() {
    return Obx((() => CustomAnimatedBottomBar(
          containerHeight: 70,
          backgroundColor: Colors.amber,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          selectedIndex: con.indexTab.value,
          onItemSelected: (index) => con.changeTab(index),
          items: [
            BottomNavyBarItem(
                icon: Icon(Icons.delivery_dining),
                title: const Text("Pedidos"),
                activeColor: Colors.white,
                inactiveColor: Colors.black),
            BottomNavyBarItem(
                icon: Icon(Icons.category_rounded),
                title: const Text("Categoria"),
                activeColor: Colors.white,
                inactiveColor: Colors.black),
            BottomNavyBarItem(
                icon: Icon(Icons.apple_sharp),
                title: const Text("Producto"),
                activeColor: Colors.white,
                inactiveColor: Colors.black),
            BottomNavyBarItem(
                icon: Icon(Icons.person),
                title: const Text("Perfil"),
                activeColor: Colors.white,
                inactiveColor: Colors.black),
          ],
        )));
  }
}
