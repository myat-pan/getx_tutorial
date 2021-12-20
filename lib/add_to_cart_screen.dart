import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:getx_example/state/products.dart';

class AddToCartScreen extends StatelessWidget {
  final ProductsController productsController = Get.find<ProductsController>();
  AddToCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add To Cart"),
      ),
      body: Obx(() => productsController.wishListItems.isEmpty
          ? const Center(
              child: Text("No Products"),
            )
          : ListView.builder(
              itemCount: productsController.wishListItems.length,
              itemBuilder: (context, i) {
                return Text(productsController.wishListItems[i].name);
              })),
    );
  }
}
