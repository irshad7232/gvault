import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:gvault/app/routes/app_pages.dart';

class SplashController extends GetxController {
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  final storage = new FlutterSecureStorage();

  Future<bool> checkApplicationStatus() async {
    bool _status = false;
    String? _value = await storage.read(key: 'hash');

    if (_value != null) {
      _status = true;
    } else {
      _status = false;
    }
    return _status;
  }

  Future<void> navigateToLoginOrSetKey() async {
    await checkApplicationStatus().then((value) {
      if (value) {
        Timer(Duration(seconds: 3), () => Get.offNamed(Routes.LOGIN));
      } else {
        Timer(Duration(seconds: 3), () => Get.offNamed(Routes.SET_KEY));
      }
    });
  }

  @override
  void onInit() async {
    _getAndroidOptions();
    await navigateToLoginOrSetKey();
    super.onInit();
  }
}
