import 'package:festival/models/role.dart';
import 'package:festival/models/user.dart';
import 'package:festival/services/user.service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  static final AuthService _singleton = initiate();

  factory AuthService() {
    return _singleton;
  }

  AuthService._internal();

  static initiate() {
    return AuthService._internal();
  }

  /// Register a new user
  Future<User?> registerUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    user = (await auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      UserService().insertUser(UserModel(user.uid, Role.user, email, []));
    }

    return user;
  }

  /// Sign in using email and password
  Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    user = userCredential.user;

    if (user != null) {
      UserService().getUser().then((user) => UserService().setLocalUser(user));
    }

    return user;
  }

  /// Sign Out
  void signOut() {
    UserService().setLocalUser(null);
    FirebaseAuth.instance.signOut();
  }

  /// Get the currently logged in user
  Future<User?> getAuthUser() async {
    return FirebaseAuth.instance.currentUser;
  }
}
