import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TextController extends GetxController {
  var text = "Default".obs;

  void textChange1() {
    text.value = "Text One";
  }

  void textChange2() {
    text.value = "Text Two";
  }
}
