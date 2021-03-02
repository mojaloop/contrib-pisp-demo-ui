import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class PlatformAwareAssetImage extends StatelessWidget {
  const PlatformAwareAssetImage({
    Key key,
    this.asset,
    this.package,
  }) : super(key: key);

  final String asset;
  final String package;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Image.network(
        'assets/${package == null ? '' : 'packages/$package/'}$asset',
      );
    }

    return Image.asset(
      asset,
      package: package,
    );
  }
}
