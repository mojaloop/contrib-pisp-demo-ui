import 'package:flutter_test/flutter_test.dart';
import 'package:pispapp/utils/utils.dart';

void main() {
  test(
    'getSecretNumberFromString()',
    () {
      expect(Utils.getSecretNumberFromString('1231231232123'), '1231*******23');
      expect(Utils.getSecretNumberFromString('123'), '123');
      expect(
          Utils.getSecretNumberFromString('ABasd123123908'), 'ABas********08');
      expect(Utils.getSecretNumberFromString('1'), '1');
      expect(Utils.getSecretNumberFromString('1234'), '1234');
      expect(Utils.getSecretNumberFromString('123456'), '123456');
    },
  );

  test(
    'getDateFromDateTime()',
    () {
      expect(Utils.getDateFromDateTime(DateTime.parse('2020-08-04T02:38:56.779Z')), '2020-08-04');
    },
  );
}
