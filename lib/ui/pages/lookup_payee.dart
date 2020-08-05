import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/ephemeral/lookup_payee_controller.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/ui/widgets/payee_tile.dart';
import 'package:pispapp/ui/widgets/title_text.dart';

class LookupPayee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LookupPayeeController>(
      builder: (value) {
        if (value.isLoading)
          return Scaffold(
            body: Container(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(LightColor.yellow2),
                ),
              ),
            ),
          );
        else
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 40, 0, 50),
                      child: TitleText(
                        text: 'Choose Payee',
                        fontSize: 20,
                      ),
                    ),
                    PayeeTile(
                      payeeName: Get.find<LookupPayeeController>().payeeName,
                      onTap: () {
                        Get.find<LookupPayeeController>().onTapPayertile();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
      },
    );
  }
}
