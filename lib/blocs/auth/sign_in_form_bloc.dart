import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dartz/dartz.dart';
import 'package:pispapp/models/auth/auth_failure.dart';
import 'package:flutter/foundation.dart';
import 'package:pispapp/models/auth/i_auth.dart';

part 'sign_in_form_event.dart';

part 'sign_in_form_state.dart';

part 'sign_in_form_bloc.freezed.dart';

class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  SignInFormBloc(this._auth);

  final IAuth _auth;

  @override
  SignInFormState get initialState => SignInFormState.initial();

  @override
  Stream<SignInFormState> mapEventToState(
    SignInFormEvent event,
  ) async* {
    yield* event.map(
      signInWithGooglePressed: (e) async* {
        yield SignInFormState(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
          showErrorMessages: false,
        );
        final failureOrSuccess = await _auth.signInWithGoogle();
        yield SignInFormState(
          isSubmitting: false,
          authFailureOrSuccessOption: some(failureOrSuccess),
          showErrorMessages: false,
        );
      },
    );
  }
}
