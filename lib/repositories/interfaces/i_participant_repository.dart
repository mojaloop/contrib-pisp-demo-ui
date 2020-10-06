import 'package:pispapp/models/fsp.dart';

/// Abstraction for methods related to read/write
/// Financial Service Provider(FSP) participant information from external data
/// sources.
abstract class IParticipantRepository {
  /// Fetches the list of participating FSPs
  Future<List<Fsp>> loadAvailableFSPs();
}
