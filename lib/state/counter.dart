import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Controller extends GetxController {
  var counter = 0.obs;

  void incre() {
    counter.value++;
  }

  void decre() {
    counter.value--;
  }
}
