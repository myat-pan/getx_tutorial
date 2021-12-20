// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:getx_example/model/item.dart';

class ProductsController extends GetxController {
  var myList = [].obs;

  final RxList<Product> products = List.generate(
      100,
      (index) => Product(
          id: index,
          name: 'Product $index',
          price: Random().nextInt(1000),
          addToCart: false)).obs;

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString("assets/json/product.json");
    final data = json.decode(response);
    print(data);
    Item item = Item.fromJson(data as Map<String, dynamic>);
    myList(item.products);
    print(myList.length);
    myList.refresh();
  }

  List<Product> get items {
    return [...myList];
  }

  List<Product> get wishListItems {
    return items.where((product) => product.addToCart == true).toList();
  }

  void addItem(int id) {
    final int index = items.indexWhere((p) => p.id == id);
    items[index].addToCart = true;
  }

  void removeItem(int id) {
    final int index = items.indexWhere((p) => p.id == id);
    items[index].addToCart = false;
  }
}
