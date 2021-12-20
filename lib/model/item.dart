import 'package:get/get.dart';

class Item {
  List<Product> products;
  Item({required this.products});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        products: List<Product>.from(
            json["products"].map((i) => Product.fromJson(i))));
  }
}

class Product {
  int id;
  String name;
  int price;
  bool addToCart;
  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.addToCart});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        addToCart: json["add_to_cart"]);
  }
}
