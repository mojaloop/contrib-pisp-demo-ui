import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/account-linking/available_fsp_controller.dart';

class AvailableFSPScreen extends StatelessWidget {
  final AvailableFSPController c = Get.find();

  Widget _buildList() {
    return Obx(() {
      if(c.fsps.value.isEmpty) {
        return const Text('No financial providers are supported currently');
      }
      return ListView.builder(
        itemCount: c.fsps.value.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Text(c.fsps.value[index]);
        },
      );
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('Choose an available provider'),
      ),
      body: _buildList(),
    );
  }
}