import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/account-linking/available_fsp_controller.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/shadow_box.dart';

class AvailableFSPScreen extends StatelessWidget {
  final AvailableFSPController c = Get.put(AvailableFSPController());

  Widget _buildListItem(String fspName) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: ShadowBox(
        color: LightColor.navyBlue1,
        child: ListTile(
          trailing: const Icon(Icons.arrow_forward_ios),
          title: Text(fspName),
        ),
      ),
    );
  }

  Widget _buildList() {
    return Obx(() {
      if(c.fsps.value.isEmpty) {
        return const Text('No financial providers are supported currently');
      }

      return ListView.builder(
        itemCount: c.fsps.value.length + 2,
        itemBuilder: (BuildContext ctxt, int index) {
          switch(index) {
            case 0:  return _buildIcon(); break;
            case 1: return _buildDescText(); break;
            default: return _buildListItem(c.fsps.value[index - 2]);
          }
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

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Icon(
        Icons.account_balance,
        color: Colors.blue,
        size: 50,),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supported financial providers'),
      ),
      body:
      SizedBox.expand(
        child: _buildList(),
      ),
    );
  }
}