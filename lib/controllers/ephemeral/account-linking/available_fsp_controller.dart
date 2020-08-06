import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AvailableFSPController extends GetxController {
  RxList<String> fsps = <String>[].obs;

  @override
  void onInit() {
    fsps.bindStream(listenForFSPs());
    super.onInit();
  }

  // Retrieve list of FSPs
  // Fetches only once
  Stream<Iterable<String>> loadFSPs() {
    CollectionReference fspRef = Firestore.instance.collection('participants');
    return fspRef.getDocuments().then((value) {
      return value.documents.map<String>((e) {
        final String s = e.data['name'] as String;
        return s;
      }).toList();
    }).asStream();
  }

  // Retrieve list of FSPs
  // This updates in real time
  Stream<Iterable<String>> listenForFSPs() {
    return Firestore.instance.collection('participants').snapshots().map((event) {
      List<String> fsps = event.documents.map((e) {
      final String s = e.data['name'] as String;
      return s;
    }).toList();
      return fsps ?? []; });
  }
}