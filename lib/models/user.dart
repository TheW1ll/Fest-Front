import 'package:festival/models/role.dart';

class UserModel {
  String id;
  Role role;
  String email;
  List<String> favoriteFestivals;

  UserModel(this.id, this.role, this.email, this.favoriteFestivals);

  factory UserModel.from(dynamic json) {
    return UserModel(
      json['id'] as String,
      Role.values[json['role'] as int],
      json['email'] as String,
      (json['favoriteFestivals'] as List<dynamic>)
          .map((dynamic e) => e as String)
          .toList(),
    );
  }

  toJson() {
    return {
      'id': id,
      'role': role.index,
      'email': email,
      'favoriteFestivals': favoriteFestivals,
    };
  }
}
