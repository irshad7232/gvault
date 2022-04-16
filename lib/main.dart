import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gvault/utils/sqflite_helper.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqfliteHelper.instance.initDatabase();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
