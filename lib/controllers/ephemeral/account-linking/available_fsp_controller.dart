import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AvailableFSPController extends GetxController {
  RxList<String> fsps = <String>[].obs;

  @override
  void onInit() {
    fsps.bindStream(loadFSPs());
    loadFSPs().listen((fsps) {
      print('KZ: $fsps');
    });
    super.onInit();
  }

  // Receive a list of { fspId: fspX , name: FSP_X }
  // Build out a list of fsp names
  Stream<Iterable<String>> loadFSPs() {
    CollectionReference fspRef = Firestore.instance.collection('participants');
    return fspRef.getDocuments().then((value) {
      return value.documents.map<String>((e) {
        final String s = e.data['name'] as String;
        return s;
      }).toList();
    }).asStream();
  }
}