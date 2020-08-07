import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pispapp/controllers/ephemeral/lookup_payee_controller.dart';
import 'package:pispapp/repositories/transaction_repository.dart';

class MockTransactionRepository extends Mock implements TransactionRepository {}
void main () {
  LookupPayeeController lookupPayeeController;
  setUp(() {
    lookupPayeeController = LookupPayeeController(MockTransactionRepository());
  });

  test('foundPayee() sets payeeName and isLoading correctly', () {
    lookupPayeeController.foundPayee('John Doe');
    expect(lookupPayeeController.payeeName, 'John Doe');
    expect(lookupPayeeController.isLoading, false);
  });
}