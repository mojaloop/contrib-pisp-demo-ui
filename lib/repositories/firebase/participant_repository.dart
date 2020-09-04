import 'package:pispapp/models/fsp.dart';
import 'package:pispapp/repositories/interfaces/i_participant_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show Firestore;

class ParticipantRepository implements IParticipantRepository {
  final _colRef = Firestore.instance.collection('participants');

  @override
  Stream<List<Fsp>> listenForAvailableFSPs() {
    return _colRef.snapshots().map((event) {
      final List<Fsp> fspList = event.documents.map((e) {
        return Fsp.fromJson(e.data);
      }).toList();
      return fspList ?? [];
    });
  }

  @override
  Future<List<Fsp>> loadAvailableFSPs() {
    return _colRef.getDocuments().then((value) {
      return value.documents.map<Fsp>((e) {
        return Fsp.fromJson(e.data);
      }).toList();
    });
  }
}
