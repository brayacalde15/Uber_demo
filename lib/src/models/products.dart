import 'dart:convert';
import 'dart:ffi';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  String? id;
  String? name;
  String? description;
  String? image1;
  String? image2;
  String? image3;
  String? idCategory;
  double? price;
  int? quantity;

  Products(
      {this.id,
      this.name,
      this.description,
      this.image1,
      this.image2,
      this.image3,
      this.idCategory,
      this.price,
      this.quantity});

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
        idCategory: json["id_category"],
        price: json["price"]?.toDouble(),
        quantity: json["quantity"],
      );

  static List<Products> fromJsonList(List<dynamic> jsonList) {
    List<Products> toList = [];
    jsonList.forEach((item) {
      Products products = Products.fromJson(item);
      toList.add(products);
    });
    return toList;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "id_category": idCategory,
        "price": price,
        "quantity": quantity
      };
}
