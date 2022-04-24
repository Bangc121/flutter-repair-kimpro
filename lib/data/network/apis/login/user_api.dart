
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kimpro/data/network/apis/login/model/user.dart';
import 'package:kimpro/data/network/apis/login/model/user_pro.dart';

class UserApi {

  /// 사용자
  final _userRef = FirebaseFirestore.instance.collection("users").withConverter<User>(
    fromFirestore: (snapshots, _) => User.fromJson(snapshots.data()),
    toFirestore: (user, _) => user.toJson(),
  );

  Future<void> saveUser(User user) async {
    return _userRef.doc(user.id).set(user);
  }

  Future<bool> isExists(String id) async {
    DocumentSnapshot<User> userDoc = await _userRef.doc(id).get();
    return userDoc.exists;
  }

  Future<User?> findUser(String uid) async {
    return _userRef.doc(uid).get().then((value) => value.data());
  }

  /// 전문가
  final _userProRef = FirebaseFirestore.instance.collection("users").withConverter<UserPro>(
    fromFirestore: (snapshots, _) => UserPro.fromJson(snapshots.data()),
    toFirestore: (userPro, _) => userPro.toJson(),
  );

  Future<void> saveUserPro(UserPro userPro) async {
    return _userProRef.doc(userPro.id).set(userPro);
  }

  Future<UserPro?> findUserPro(String uid) async {
    return _userProRef.doc(uid).get().then((value) => value.data());
  }

}