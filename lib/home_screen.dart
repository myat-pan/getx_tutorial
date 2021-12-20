import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/model/item.dart';
import 'package:getx_example/state/counter.dart';
import 'package:getx_example/state/load_more.dart';
import 'package:getx_example/state/products.dart';
import 'package:getx_example/state/text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  final Controller controller = Get.put(Controller());
  final TextController textController = Get.put(TextController());
  final ProductsController productController = Get.put(ProductsController());
  final LoadMoreController loadMoreController = Get.put(LoadMoreController());

  // Widget _count() {
  //   return Column(children: [
  //     GetX<Controller>(
  //       init: Controller(),
  //       builder: (value) => Text("${value.counter.value}"),
  //     ),
  //     ElevatedButton(
  //         onPressed: () {
  //           controller.incre();
  //         },
  //         child: const Text("Increment")),
  //     ElevatedButton(
  //         onPressed: () {
  //           controller.decre();
  //         },
  //         child: const Text("Decrement")),
  //     Obx(() => Text(textController.text.value)),
  //     // GetX<TextController>(builder: (val) => Text(val.text.value)),
  //     ElevatedButton(
  //         onPressed: () {
  //           textController.textChange1();
  //         },
  //         child: const Text("Change Text One")),
  //     ElevatedButton(
  //         onPressed: () {
  //           textController.textChange2();
  //         },
  //         child: const Text("Change Text One"))
  //   ]);
  // }

  @override
  Widget build(BuildContext context) {
    // loadMoreController.generateList();
    loadMoreController.loadMore();
    loadMoreController.firstLoad();
    return Scaffold(
        appBar: AppBar(
          title: const Text('GetX Example'),
          actions: const [Icon(Icons.shopping_cart)],
        ),
        body: Obx(() {
          return loadMoreController.isFastLoadRunning
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(children: [
                  Expanded(
                    child: ListView.builder(
                        controller: loadMoreController.controller,
                        itemCount: loadMoreController.list.length,
                        itemBuilder: (context, i) {
                          return InkWell(
                              onTap: () => Get.toNamed("/addToCart"),
                              child: Card(
                                elevation: 10,
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 42,
                                    child: Text(
                                      "${(i + 1)}. " +
                                          loadMoreController.list[i]["title"],
                                    )),
                              ));
                        }),
                  ),
                  if (loadMoreController.isMoreLoadRunning == true)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  if (loadMoreController.hasNextPage == false)
                    Container(
                      color: Colors.amber,
                      child: const Center(
                        child: Text("No more Data."),
                      ),
                    )
                ]);
        }));
  }
}
