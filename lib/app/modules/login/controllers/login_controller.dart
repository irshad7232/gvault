import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:gvault/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final storage = new FlutterSecureStorage();

  Future<void> openFileContainer(String password) async {
    String? _salt = await storage.read(key: 'salt');
    String? _storedHash = await storage.read(key: 'hash');
    if (_salt != null && _storedHash != null) {
      final _value = _salt + password;
      var _bytes = utf8.encode(_value);
      var _hash = sha256.convert(_bytes);
      if (_storedHash == '$_hash') {
        var _passwordBytes = utf8.encode(password);
        var _passwordHash = sha256.convert(_passwordBytes);
        await storage.write(
          key: 'paasword_hash',
          value: '$_passwordHash',
        );
        Get.offNamed(Routes.HOME);
      } else {
        print('password error');
      }
    } else {
      print('err');
    }
  }

  @override
  void onInit() async {
    await openFileContainer('178835');
    super.onInit();
  }
}
