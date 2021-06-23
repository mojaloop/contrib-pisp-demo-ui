import 'package:fido2_client/authenticator_attestation_response.dart';
import 'package:pispapp/utils/utils.dart';

class ParsedAuthenticatorAttestationResponse {
  ParsedAuthenticatorAttestationResponse(
      {this.clientDataJSON, this.attestationObject});

  String clientDataJSON;
  String attestationObject;

  static ParsedAuthenticatorAttestationResponse fromAuthenticatorResponse(
      AuthenticatorAttestationResponse ar) {
    return ParsedAuthenticatorAttestationResponse(
        attestationObject:
            Utils.uint8BufferToBase64String(ar.attestationObject),
        clientDataJSON: Utils.uint8BufferToBase64String(ar.clientDataJSON));
  }

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('clientDataJSON', clientDataJSON);
    writeNotNull('attestationObject', attestationObject);
    return val;
  }

  static ParsedAuthenticatorAttestationResponse fromJson(
      Map<String, dynamic> json) {
    return ParsedAuthenticatorAttestationResponse(
        clientDataJSON: json['clientDataJSON'] as String,
        attestationObject: json['attestationObject'] as String);
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
