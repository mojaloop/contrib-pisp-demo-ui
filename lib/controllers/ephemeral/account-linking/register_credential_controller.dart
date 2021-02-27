import 'package:get/get.dart';

class RegisterCredentialController extends GetxController {
  String signedChallenge;

  void onChallengeSigned(String signedChallenge) {
    this.signedChallenge = signedChallenge;
  }
}
