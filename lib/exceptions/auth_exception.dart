class AuthenticationException implements Exception {
  AuthenticationException(this.s);
  factory AuthenticationException.serverError() => AuthenticationException('Internal server error');
  factory AuthenticationException.cancelledByUser() => AuthenticationException('Authentication cancelled by user');


  String s;

  @override
  String toString() {
    return s;
  }
}