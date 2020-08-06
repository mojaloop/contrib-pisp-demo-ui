
class Utils {

  static String getSecretAccountNumberFromString(String accountNumber) {
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
}
