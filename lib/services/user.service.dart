import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festival/models/user.dart';
import 'package:festival/models/role.dart';
import 'package:festival/services/FireConn.dart';
import 'package:festival/services/auth.service.dart';

class UserService {
  static final UserService _singleton = initialize();

  UserService._internal();

  factory UserService() {
    return _singleton;
  }

  UserModel? _localUser;
  static CollectionReference userCollectionReference = userCollectionReference;

  static initialize() {
    userCollectionReference = FireConn().getUserCollection();
    return UserService._internal();
  }

  /// Set the local user
  setLocalUser(UserModel? user) {
    _localUser = user;
  }

  /// Get the local user from FireAuth
  Future<UserModel?> getUser() async {
    return AuthService().getAuthUser().then((authUser) {
      if (authUser != null) {
        return userCollectionReference
            .doc(authUser.uid)
            .get()
            .then((userDocument) {
          UserModel user = UserModel.from(userDocument);
          setLocalUser(user);
          return user;
        });
      }
      return null;
    });
  }

  /// Check if the currently logged in user is logged in
  bool isLoggedIn() {
    return _localUser != null;
  }

  /// Check if the currently logged in user has role admin
  bool isAdmin() {
    return _localUser?.role == Role.admin;
  }

  /// Check if the currently logged in user has role user
  bool isUser() {
    return _localUser?.role == Role.user;
  }

  /// Add a festival to the favorite list of the currently logged in user
  Future addFestivalToFavorites(String festivalId) async {
    _localUser?.favoriteFestivals.add(festivalId);
    return userCollectionReference
        .doc(_localUser?.id)
        .update({'favorites': FieldValue.arrayUnion([festivalId])});
  }

  /// Remove a festival from the favorite list of the currently logged in user
  Future removeFestivalFromFavorites(String festivalId) async {
    _localUser?.favoriteFestivals.remove(festivalId);
    return userCollectionReference
        .doc(_localUser?.id)
        .update({'favorites': FieldValue.arrayRemove([festivalId])});
  }

  Future insertUser(UserModel userModel) async{
    return userCollectionReference
        .doc(userModel.id)
        .set(userModel);
  }
}
