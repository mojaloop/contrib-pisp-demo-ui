import 'package:get/get.dart';

class WebAuthController extends GetxController {
  // FSPs must redirect the user to a URI:
  // with pisp as the scheme and token as a queryParam.
  // i.e. pisp://success?token=1234567
  static const customScheme = 'pisp';

  String extractAuthTokenFromResult(String result) {
    final token = Uri.parse(result).queryParameters['token'];
    return token;
  }
}
