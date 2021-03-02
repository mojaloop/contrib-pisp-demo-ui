import 'package:flutter/material.dart';
import 'package:pispapp/ui/widgets/PlatformAwareAssetImage.dart';

class Pineapple extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
        // child: Image(image: AssetImage('assets/pineapple.svg')));
        child: PlatformAwareAssetImage(asset: 'assets/pineapple.png'));
  }
}
