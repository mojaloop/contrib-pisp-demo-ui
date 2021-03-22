import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pispapp/controllers/app/user_data_controller.dart';
import 'package:pispapp/models/user.dart';
import 'package:pispapp/repositories/firebase/auth_repository.dart';
import 'package:pispapp/repositories/firebase/user_data_repository.dart';

class AuthController extends GetxController {
  AuthController(this._authRepository);

  AuthRepository _authRepository;

  User user;

  bool get userSignedIn => user != null;

  // NOTE: Should only be called after user login
  @visibleForTesting
  Future<void> createUserDataControllerAndCreateUserEntity(User user) async {
    assert(user != null);

    // Since it has been determined that the user is logged in
    // we can create the user data controller.
    final UserDataController _userDataController =
        Get.put(UserDataController(UserDataRepository(), user));

    // Create a user entity in the database if it does not exist already
    await _userDataController.createUserEntryInDB();
    await _userDataController.loadAuxiliaryInfoForUser();
  }

  Future<User> signInWithGoogle() async {
    final user = await _authRepository.signInWithGoogle();
    setUser(user);
    createUserDataControllerAndCreateUserEntity(user);

    return user;
  }

  Future<void> signOut() async {
    await _authRepository.signOut(user);
    user = null;
    await Get.delete<UserDataController>();
  }

  void setUser(User user) {
    this.user = user;
    update();
  }
}
