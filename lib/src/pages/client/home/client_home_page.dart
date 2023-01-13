import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:uber_demo_udemy/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:uber_demo_udemy/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:uber_demo_udemy/src/pages/register/register_page.dart';
import 'package:uber_demo_udemy/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:uber_demo_udemy/src/utils/custom_animated_bottom_bar.dart';

import 'client_home_controller.dart';

class ClientHomePage extends StatelessWidget {
  ClientHomeController con = Get.put(ClientHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _bottomBar(),
        body: Obx((() => IndexedStack(
              index: con.indexTab.value,
              children: [
                RestaurantOrdersListPage(),
                DeliveryOrdersListPage(),
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
                icon: Icon(Icons.apps),
                title: const Text("Home"),
                activeColor: Colors.white,
                inactiveColor: Colors.black),
            BottomNavyBarItem(
                icon: Icon(Icons.delivery_dining),
                title: const Text("Mis pedidos"),
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
