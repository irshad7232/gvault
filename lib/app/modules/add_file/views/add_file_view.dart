import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_file_controller.dart';

class AddFileView extends GetView<AddFileController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          appBar: AppBar(
            title: Text('AddFileView'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Container(
                  width: Get.width,
                  height: Get.height - 200,
                  child: controller.encodedImage.value == ''
                      ? Text('image is not loaded')
                      : Image.memory(
                          base64Decode(controller.encodedImage.value))),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () => controller.loadFile(),
                      child: Text('load')),
                  ElevatedButton(
                      onPressed: () => controller.addImage(),
                      child: Text('upload')),
                ],
              )
            ],
          )),
    );
  }
}
