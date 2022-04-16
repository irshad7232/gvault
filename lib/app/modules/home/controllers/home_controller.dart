import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:gvault/utils/aes_helper.dart';
import 'package:gvault/utils/sqflite_helper.dart';

import '../../../../utils/global.dart';

class HomeController extends GetxController {
  final storage = new FlutterSecureStorage();

  final loadingState = false.obs;

  RxList<GlobalFile> _globalFiles = RxList<GlobalFile>([]);

  RxList<Bs64File> _bs64File = RxList<Bs64File>([]);

  List<Bs64File> get bs64File {
    return [..._bs64File.reversed];
  }

  Future<void> loadBs64FilesFromGlobalFiles() async {
    _bs64File.clear();
    var _fileList = await SqfliteHelper.instance.loadFiles();

    _fileList.forEach((element) async {
      var bs64File = await getBs64FileFromAes(element);

      _bs64File.add(bs64File);
    });
  }

  Future<Bs64File> getBs64FileFromAes(GlobalFile globalFile) async {
    String? _storedHash = await storage.read(key: 'paasword_hash');
    int? id = globalFile.id;
    FileType fileType = globalFile.fileType;
    String bs64hash = AesHelper.decrypt(_storedHash ?? '', globalFile.hash);
    DateTime dateTime = globalFile.dateTime;
    IsFavorite isFavorite = globalFile.isFav!;
    return Bs64File(
        id: id, fileType: fileType, bs64: bs64hash, dateTime: dateTime);
  }

  @override
  void onInit() async {
    loadingState.value = true;

    await loadBs64FilesFromGlobalFiles().then((value) {
      loadingState.value = false;
    });

    await SqfliteHelper.instance.loadFiles().then((value) {
      value.forEach((element) {
        print(element.hash);
      });
    });
    super.onInit();
  }
}
