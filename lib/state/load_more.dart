import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_example/model/item.dart';
import 'package:getx_example/model/name_model.dart';
import 'package:http/http.dart' as http;

class LoadMoreController extends GetxController {
  var list = [].obs;
  ScrollController controller = ScrollController();
  var listLength = 0.obs;

  final baseUrl = "https://jsonplaceholder.typicode.com/posts";
  var page = 0;
  var limit = 20;
  bool hasNextPage = true;
  bool isFastLoadRunning = false;
  bool isMoreLoadRunning = false;

  // generateList() {
  //   list = List.generate(
  //       listLength.toInt(), (index) => Model(name: "Product ${index + 1}")).obs;
  // }

  // Future<void> readJson() async {
  //   final String response =
  //       await rootBundle.loadString("assets/json/product.json");
  //   final data = json.decode(response);
  //   Item item = Item.fromJson(data);
  //   list(item.products);
  //   print(list.length);
  //   //  print(listLength);
  //   list.refresh();
  // }

  Future<void> loadUrl() async {
    final response =
        await http.get(Uri.parse("$baseUrl?page=$page&limit=$limit"));
    final data = json.decode(response.body);
  }

  List<Product> get products {
    return [...list];
  }

  addItems() async {
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        for (int i = 0; i < 2; i++) {
          listLength.value++;
          list.add(Product(id: i, name: "name", price: 10, addToCart: false));
          // update();
        }
      }
    });
  }

  void firstLoad() async {
    isFastLoadRunning = true;
    try {
      loadUrl();
    } catch (e) {
      print(e);
    }
    isFastLoadRunning = false;
  }

  void loadMore() async {
    if (hasNextPage == true &&
        isFastLoadRunning == false &&
        isMoreLoadRunning == false) {
      isMoreLoadRunning = true;
      // && controller.position.extentAfter < 300) {
      page += 1;
      try {
        final res =
            await http.get(Uri.parse("$baseUrl?page=$page&limit=$limit"));
        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          list.addAll(fetchedPosts);
        } else {
          hasNextPage == false;
        }
      } catch (e) {
        print(e);
      }
      // }
      isMoreLoadRunning = false;
    }
  }
}
