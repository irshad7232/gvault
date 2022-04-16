import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/set_key_controller.dart';

class SetKeyView extends GetView<SetKeyController> {
  @override
  Widget build(BuildContext context) {
    controller.initialized;
    return Scaffold(
      appBar: AppBar(
        title: Text('SetKeyView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SetKeyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
