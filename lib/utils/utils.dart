import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:intl/intl.dart';
import 'package:jcs_dart/jcs_dart.dart';
import 'package:pispapp/models/consent.dart';

class Utils {
  static String getSecretNumberFromString(String accountNumber) {
    final StringBuffer sb = StringBuffer();
    for (int i = 0; i < accountNumber.length; i++) {
      if (i >= 4 && i <= accountNumber.length - 3) {
        sb.write('*');
      } else {
        sb.write(accountNumber[i]);
      }
    }
    return sb.toString();
  }

  static String getDateFromDateTime(DateTime dt) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(dt);
    return formatted;
  }

  /// Derives a challenge from the consent, based on
  /// https://github.com/mojaloop/pisp/blob/master/docs/linking/README.md#161-deriving-the-challenge
  ///
  static String deriveChallengeFromConsent(Consent consent) {
    final Map<String, dynamic> baseObject = {
      'consentId': consent.consentId,
      'scopes': consent.scopes
    };

    // Convert to a JSON String
    const encoder = JsonEncoder();
    final nonCanonicalString = encoder.convert(baseObject);

    // Canonicalize
    final canonicalString =
        JsonCanonicalizer().canonicalize(nonCanonicalString);

    print('deriveChallengeFromConsent, canonical payload string: ' +
        canonicalString);

    // SHA256 the Canonical JSON representation
    final bytes = utf8.encode(canonicalString);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static String uint8BufferToBase64String(List<int> buffer) {
    return base64Encode(buffer);
  }

  static List<int> base64StringToUInt8Buffer(String base64Str) {
    return base64Decode(base64Str).map((e) => e.toInt()).toList();
  }

  static T _$enumDecode<T>(
    Map<T, dynamic> enumValues,
    dynamic source, {
    T unknownValue,
  }) {
    if (source == null) {
      throw ArgumentError('A value must be provided. Supported values: '
          '${enumValues.values.join(', ')}');
    }

    final value = enumValues.entries
        .singleWhere((e) => e.value == source, orElse: () => null)
        ?.key;

    if (value == null && unknownValue == null) {
      throw ArgumentError('`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}');
    }
    return value ?? unknownValue;
  }

  static T $enumDecodeNullable<T>(
    Map<T, dynamic> enumValues,
    dynamic source, {
    T unknownValue,
  }) {
    if (source == null) {
      return null;
    }
    return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
  }
}
