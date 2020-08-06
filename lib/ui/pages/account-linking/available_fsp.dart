import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/account-linking/available_fsp_controller.dart';

class AvailableFSPScreen extends StatelessWidget {
  final AvailableFSPController c = Get.find();

  Widget _buildListItem(String fspName) {
    return Container(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Container(
          child: ListTile(
            trailing: const Icon(Icons.arrow_forward_ios),
            title: Text(fspName),
          ),
          decoration: BoxDecoration(color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]
          ),
        )
    );
  }

  Widget _buildList() {
    return Obx(() {
      if(c.fsps.value.isEmpty) {
        return const Text('No financial providers are supported currently');
      }

      return ListView.builder(
        itemCount: c.fsps.value.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return _buildListItem(c.fsps.value[index]);
        },
      );
    }
    );
  }

  Widget _buildDescText() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: const Text('Please choose the financial provider of the account that you would like to link:',),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supported financial providers'),
      ),
      body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          _buildDescText(),
          Expanded(
            child: _buildList(),),
        ]),
      );
  }
}