import 'package:get/get.dart';
import 'package:dummy1/Widgets/network/NetworkManger.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(NetworkManager());
  }

}