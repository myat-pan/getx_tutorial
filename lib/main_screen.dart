// ignore_for_file: unrelated_type_equality_checks, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_example/add_to_cart_screen.dart';
import 'package:getx_example/model/item.dart';
import 'package:getx_example/state/counter.dart';
import 'package:getx_example/state/products.dart';

class MainScreen extends StatelessWidget {
  final Controller controller = Get.put(Controller());
  final ProductsController productsController = Get.put(ProductsController());

  MainScreen({Key? key}) : super(key: key);

  Widget cardSection(
    Product _product,
  ) {
    return Card(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(_product.name),
        IconButton(
            onPressed: () {
              if (_product.addToCart == false) {
                controller.incre();
                productsController.addItem(_product.id);
              } else if (_product.addToCart == true) {
                controller.decre();
                productsController.removeItem(_product.id);
              }
              print(_product.addToCart);
            },
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: _product.addToCart == false ? Colors.red : Colors.green,
            )),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    productsController.readJson();
    return Scaffold(
        appBar: AppBar(
          title: const Text("GetX Example"),
          actions: [
            Container(
              margin: const EdgeInsets.all(8),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Obx(() => Text(
                        controller.counter.value.toString(),
                      )),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddToCartScreen()));
                      },
                      icon: const Icon(Icons.shopping_cart))
                ],
              ),
            ),
          ],
        ),
        body: Obx(() {
          return productsController.items.isEmpty
              ? const Center(
                  child: Text("Empty"),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 12),
                  itemCount: productsController.items.length,
                  itemBuilder: (context, int i) {
                    return cardSection(productsController.items[i]);
                  });
        }));
  }
}
