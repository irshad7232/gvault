import 'package:get/get.dart';

import '../controllers/set_key_controller.dart';

class SetKeyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetKeyController>(
      () => SetKeyController(),
    );
  }
}
