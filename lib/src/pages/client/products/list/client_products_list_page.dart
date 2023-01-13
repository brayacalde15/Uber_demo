import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:uber_demo_udemy/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:uber_demo_udemy/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:uber_demo_udemy/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:uber_demo_udemy/src/pages/register/register_page.dart';
import 'package:uber_demo_udemy/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:uber_demo_udemy/src/utils/custom_animated_bottom_bar.dart';

class ClientProductsListPage extends StatelessWidget {
  ClientProductsListController con = Get.put(ClientProductsListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text("CLIENT PRODUCTS LIST"),
    ));
  }
}
