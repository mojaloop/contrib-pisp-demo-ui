import 'package:flutter/material.dart';
import 'package:pispapp/ui/theme/light_theme.dart';
import 'package:pispapp/models/transaction.dart';

class TransactionUIData {
  TransactionUIData(this._transaction);

  Transaction _transaction;

  IconData get iconData {
    switch (_transaction.status) {
      case TransactionStatus.success:
        return Icons.check_circle_outline;
      case TransactionStatus.authorizationRequired:
      case TransactionStatus.pendingPayeeConfirmation:
        return Icons.hourglass_empty;
      default:
        return Icons.error_outline;
    }
  }

  Color get textColor {
    switch (_transaction.status) {
      case TransactionStatus.success:
        return Colors.green;
      case TransactionStatus.authorizationRequired:
      case TransactionStatus.pendingPayeeConfirmation:
        return LightColor.yellow2;
      default:
        return Colors.red;
    }
  }

  String get textData {
    switch (_transaction.status) {
      case TransactionStatus.success:
        return 'Successful';
      case TransactionStatus.authorizationRequired:
      case TransactionStatus.pendingPayeeConfirmation:
        return 'Pending';
      default:
        return 'Error';
    }
  }
}
