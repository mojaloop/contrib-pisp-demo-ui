import 'package:flutter_test/flutter_test.dart';
import 'package:pispapp/models/authentication.dart';
import 'package:collection/collection.dart';

void main() {
  Map<String, dynamic> json;
  Authentication auth;
  setUp(() {
    json = <String, dynamic>{
      'type': 'U2F',
      'value': 'asdAhasdkljassdaASD2131bA',
    };

    auth = Authentication(type: 'U2F', value: 'asdAhasdkljassdaASD2131bA');
  });

  test('fromJson() makes correct object', () {
    final Authentication authObject = Authentication.fromJson(json);
    expect(authObject == auth, true);
  });

  test('toJson() makes correct map', () {
    final Function eq = const DeepCollectionEquality().equals;
    final Map<String, dynamic> jsonFromAuth = auth.toJson();
    expect(eq(json, jsonFromAuth), true);
  });
}
