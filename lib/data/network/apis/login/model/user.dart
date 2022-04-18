import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final id;
  final nickName; // 닉네임
  final isBusiness; // 사업자여부
  final regDateTime; // 등록일시

  User({required this.id, required this.nickName, required this.isBusiness, required this.regDateTime});

  /// firestore 저장시에 사용
  Map<String, Object> toJson() {
    return {
      UserMapKey.id: id,
      UserMapKey.nickName: nickName,
      UserMapKey.isBusiness: isBusiness,
      UserMapKey.regDateTime: regDateTime,
    };
  }

  /// firestore 에서 읽어들일 때 사용
  factory User.fromJson(Map<String, dynamic>? json) {
    return User(
      id: json![UserMapKey.id],
      nickName: json[UserMapKey.nickName],
      isBusiness: json[UserMapKey.isBusiness],
      regDateTime:  (json[UserMapKey.regDateTime] as Timestamp).toDate(),
    );
  }
}

// 모델 속성
class UserMapKey {
  static const id = 'id';
  static const nickName = 'nickName';
  static const isBusiness = 'isBusiness';
  static const regDateTime = 'regDateTime';
}
