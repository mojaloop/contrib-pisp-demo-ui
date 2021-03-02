import 'package:flutter/material.dart';
import 'package:pispapp/ui/widgets/PlatformAwareAssetImage.dart';

class Pineapple extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: 100,
        child: Align(
            alignment: Alignment.centerLeft,
            child: PlatformAwareAssetImage(asset: 'assets/pineapple.png')));
  }
}
