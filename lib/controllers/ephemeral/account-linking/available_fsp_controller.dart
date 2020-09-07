import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pispapp/models/fsp.dart';
import 'package:pispapp/repositories/firebase/participant_repository.dart';

class AvailableFSPController extends GetxController {
  AvailableFSPController(this._participantRepository);

  final ParticipantRepository _participantRepository;
  RxList<Fsp> availableFsps = <Fsp>[].obs;

  @override
  Future<void> onInit() async {
    availableFsps.value = await _participantRepository.loadAvailableFSPs();
    super.onInit();
  }
}
