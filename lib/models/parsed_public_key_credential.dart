import 'package:fido2_client/authenticator_attestation_response.dart';
import 'package:fido2_client/public_key_credential.dart';
import 'package:pispapp/models/parsed_authenticator_response.dart';
import 'package:pispapp/utils/utils.dart';

class ParsedPublicKeyCredential {
  String id;
  String rawId;
  ParsedAuthenticatorAttestationResponse response;
  String type = 'public-key';

  ParsedPublicKeyCredential({this.id, this.rawId, this.response});

  static ParsedPublicKeyCredential fromPublicKeyCredential(
      PublicKeyCredential pkc) {
    final authenticatorResponse =
        ParsedAuthenticatorAttestationResponse.fromAuthenticatorResponse(
            pkc.response as AuthenticatorAttestationResponse);

    return ParsedPublicKeyCredential(
        id: pkc.id,
        rawId: Utils.uint8BufferToBase64String(pkc.rawId),
        response: authenticatorResponse);
  }

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('id', id);
    writeNotNull('rawId', rawId);
    writeNotNull('response', response.toJson());
    writeNotNull('type', type);
    return val;
  }

  static ParsedPublicKeyCredential fromJson(Map<String, dynamic> json) {
    return ParsedPublicKeyCredential(
      id: json['id'] as String,
      rawId: json['rawId'] as String,
      response: json['response'] == null
          ? null
          : ParsedAuthenticatorAttestationResponse.fromJson(
              json['response'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
