
import 'package:flutter_test/flutter_test.dart';
import 'package:pispapp/models/user.dart';
import 'package:collection/collection.dart';

void main() {
  Map<String, dynamic> json;
  User user;
  setUp(() {
    json = <String, dynamic>{
      'displayName': 'John Doe',
      'email': 'john@example.com',
      'photoUrl': 'https://abc.com/john',
      'uid': 'asdAhasdkljassdaASD2131bA'
    };

    user = User(displayName: 'John Doe', email: 'john@example.com', photoUrl: 'https://abc.com/john', uid: 'asdAhasdkljassdaASD2131bA',);

  });

  test('fromJson() makes correct object', () {
    final User userObject = User.fromJson(json);
    expect(userObject == user, true);

  });

  test('toJson() makes correct map', () {
    final Function eq = const DeepCollectionEquality().equals;
    final Map<String, dynamic> jsonFromUser = user.toJson();
    expect(eq(json, jsonFromUser), true);
  });
}