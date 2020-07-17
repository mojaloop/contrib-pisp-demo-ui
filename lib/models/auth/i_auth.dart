
import 'package:dartz/dartz.dart';
import 'package:pispapp/models/auth/auth_failure.dart';


abstract class IAuth {
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
}