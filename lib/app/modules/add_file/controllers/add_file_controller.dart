import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:gvault/app/routes/app_pages.dart';
import 'package:gvault/utils/aes_helper.dart';
import 'package:gvault/utils/global.dart';
import 'package:gvault/utils/sqflite_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddFileController extends GetxController {
  final storage = new FlutterSecureStorage();

  var encodedImage = ''.obs;

  Future<String> selectFile() async {
    String _imagePath = '';

    File _file;
    late ImagePicker _imagePicker = ImagePicker();

    var status = await Permission.storage.status;
    if (status.isGranted) {
      String? _passwordHash = await storage.read(key: 'paasword_hash');
      if (_passwordHash != null) {
        XFile? _image =
            await _imagePicker.pickImage(source: ImageSource.gallery);
        if (_image != null) {
          _file = File(_image.path);

          String img = base64Encode(_file.readAsBytesSync());

          _imagePath = img;
        } else {
          print('select image first');
        }
      } else {
        print('password hash is empty');
      }
    } else {
      print('status is not granted');
    }
    return _imagePath;
  }

  Future<void> loadFile() async {
    await selectFile().then((value) {
      encodedImage.value = value;
    });
  }

  Future<void> addImage() async {
    String? _passwordHash = await storage.read(key: 'paasword_hash');
    if (_passwordHash != null) {
      var _encryptedImage =
          AesHelper.encrypt(_passwordHash, encodedImage.value);
      var model = GlobalFile(
          fileType: FileType.image,
          hash: _encryptedImage,
          dateTime: DateTime.now());
      await SqfliteHelper.instance
          .insertFiles(model)
          .then((value) => Get.offAllNamed(Routes.HOME));
    }
  }
}
