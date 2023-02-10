import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:uber_demo_udemy/src/models/category.dart';
import 'package:uber_demo_udemy/src/models/products.dart';
import 'package:uber_demo_udemy/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:uber_demo_udemy/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:uber_demo_udemy/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:uber_demo_udemy/src/pages/register/register_page.dart';
import 'package:uber_demo_udemy/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:uber_demo_udemy/src/utils/custom_animated_bottom_bar.dart';
import 'package:uber_demo_udemy/src/widgets/no_data_widget.dart';

class ClientProductsListPage extends StatelessWidget {
  ClientProductsListController con = Get.put(ClientProductsListController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultTabController(
          length: con.listCategories.length,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: AppBar(
                bottom: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.amber,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey[500],
                  tabs:
                      List<Widget>.generate(con.listCategories.length, (index) {
                    return Tab(
                      child: Text(
                        con.listCategories[index].name ?? '',
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }),
                ),
              ),
            ),
            body: TabBarView(
              children: con.listCategories.map((Category category) {
                return FutureBuilder(
                    future: con.getProducts(category.id ?? '1'),
                    builder: (context, AsyncSnapshot<List<Products>> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.length > 0) {
                          return ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (_, index) {
                                return _cardProduct(snapshot.data![index]);
                              });
                        } else {
                          return NoDataWidget(
                            text: 'No hay Producto Disponible',
                          );
                        }
                      } else {
                        return NoDataWidget(
                          text: 'No hay Producto Disponible',
                        );
                      }
                    });
              }).toList(),
            ),
          ),
        ));
  }

  Widget _cardProduct(Products products) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 15, left: 20, right: 20),
          child: ListTile(
            title: Text(products.name ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 4,
                ),
                Text(
                  products.description ?? '',
                  maxLines: 4,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '\$${products.price.toString()}',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
            trailing: Container(
              height: 130,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: FadeInImage(
                  image: products.image1 != null
                      ? NetworkImage(products.image1!)
                      : AssetImage("assets/img/delivery.png") as ImageProvider,
                  fit: BoxFit.contain,
                  fadeInDuration: Duration(milliseconds: 50),
                  placeholder: AssetImage("assets/img/delivery.png"),
                ),
              ),
            ),
          ),
        ),
        Divider(
          height: 1,
          color: Colors.grey[400],
          indent: 30,
          endIndent: 30,
        )
      ],
    );
  }
}
