import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/ui/widgets/icon.dart';

class Operations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        CustomIcon(
          Icons.delete_sweep,
          'Unlink',
          onTap: () => Get.toNamed<dynamic>('/account-unlinking'),
        ),
        CustomIcon(Icons.code, 'QR Pay'),
      ],
    );
  }
}
