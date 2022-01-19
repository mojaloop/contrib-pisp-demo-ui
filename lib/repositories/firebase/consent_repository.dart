import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pispapp/models/consent.dart';
import 'package:pispapp/repositories/interfaces/i_consent_repository.dart';

class ConsentRepository extends GetxService implements IConsentRepository {
  final CollectionReference _consentRef =
      FirebaseFirestore.instance.collection('consents');

  List<Consent> cache;

  @override
  Future<List<Consent>> getConsents(String userId,
      {bool preferCached = false}) {
    if (preferCached) {
      final List<Consent> cached = _getCachedConsents();
      if (cached != null) {
        return Future.value(cached);
      }
    }

    // Otherwise if no cache exists or user did not want cached results
    return _consentRef.where('userId', isEqualTo: userId).get().then(
      (snapshot) {
        cache = snapshot.docs.map((element) {
          final Consent c = Consent.fromJson(element.data());
          c.id = element.id;
          return c;
        }).toList();
        return cache;
      },
    );
  }

  @override
  Future<List<Consent>> getActiveConsents(String userId,
      {bool preferCached = false}) {
    if (preferCached) {
      final List<Consent> cached = _getCachedActiveConsents();
      if (cached != null) {
        return Future.value(cached);
      }
    }
    // Otherwise if no cache exists or user did not want cached results
    return getConsents(userId).then((consents) {
      return consents.where((c) => c.status == ConsentStatus.active).toList();
    });
  }

  /// Returns the last result of calling [getConsents()] or null if there
  /// was no previous call to [getConsents()]
  List<Consent> _getCachedConsents() {
    return cache;
  }

  /// Returns the last result of calling [getConsents()] filtered where consent
  /// status is [ConsentStatus.active] or null if there was no previous call to
  /// [getConsents()]
  List<Consent> _getCachedActiveConsents() {
    return _getCachedConsents()
        ?.where((c) => c.status == ConsentStatus.active)
        ?.toList();
  }

  @override
  Future<String> add(Map<String, dynamic> data) async {
    final docRef = await _consentRef.add(data);
    return docRef.id;
  }

  @override
  Future<void> updateData(String id, Map<String, dynamic> data) async {
    await _consentRef.document(id).setData(data, merge: true);
  }

  @override
  void Function() listen(String id, {ConsentHandler onValue}) {
    final subscription = _consentRef.document(id).snapshots().listen((event) {
      onValue(Consent.fromJson(event.data));
    });

    return () => subscription.cancel();
  }

  @override
  Future<void> setData(String id, Map<String, dynamic> data,
      {bool merge = false}) async {
    await _consentRef.document(id).setData(data, merge: merge);
  }
}
