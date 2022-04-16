import 'package:get/get.dart';

import '../controllers/add_file_controller.dart';

class AddFileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddFileController>(
      () => AddFileController(),
    );
  }
}
