import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';

class SetKeyController extends GetxController {
  final storage = new FlutterSecureStorage();

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890/*-+.<>,./>;:][{}\|!@#\$%^&*()_+';
  Random _rndom = Random();

  String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(
            _rndom.nextInt(_chars.length),
          ),
        ),
      );

  Future<void> setSalt() async {
    await storage.write(key: 'salt', value: getRandomString(256));
  }

  Future<void> setHash(String password) async {
    String? _salt = await storage.read(key: 'salt');
    if (_salt != null) {
      final _value = _salt + password;
      var _bytes = utf8.encode(_value);
      var _hash = sha256.convert(_bytes);
      await storage.write(key: 'hash', value: '$_hash');
      print(_hash);
    } else {
      print('salt not found clear app storage');
    }
  }

  @override
  void onInit() {
    setSalt();
    setHash('178835');
    super.onInit();
  }
}
