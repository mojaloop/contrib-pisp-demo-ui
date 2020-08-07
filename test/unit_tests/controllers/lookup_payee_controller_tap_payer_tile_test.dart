import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:pispapp/controllers/ephemeral/lookup_payee_controller.dart';
import 'package:pispapp/repositories/transaction_repository.dart';
import 'package:pispapp/routes/custom_navigator.dart';

class MockTransactionRepository extends Mock implements TransactionRepository {}
class MockCustomNavigator extends Mock implements CustomNavigator {}

void main() {
  LookupPayeeController lookupPayeeController;
  CustomNavigator navigator;
  setUp(() {
    lookupPayeeController = LookupPayeeController(MockTransactionRepository());
    navigator = MockCustomNavigator();
    Get.put(navigator);
  });

  test('onTapPayerTile() navigates to /transfer/finalize', () {
    lookupPayeeController.onTapPayertile();
    verify(navigator.toNamed('/transfer/finalize'));
  });
}
