import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gvault/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    controller.initialized;
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('HomeView'),
          centerTitle: true,
        ),
        body: Center(
            child: ListView.builder(
          itemBuilder: (ctx, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 250,
                child: Image.memory(
                  base64Decode(controller.bs64File[index].bs64),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          itemCount: controller.bs64File.length,
        )),
        floatingActionButton:
            FloatingActionButton(onPressed: () => Get.toNamed(Routes.ADD_FILE)),
      ),
    );
  }
}
