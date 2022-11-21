import 'package:cloud_firestore/cloud_firestore.dart';

class FireConn {
  static final FireConn _singleton = FireConn._internal();
  var db = FirebaseFirestore.instance;

  factory FireConn() {
    return _singleton;
  }

  FireConn._internal();

  CollectionReference getUserCollection() {
    return db.collection('users');
  }
}