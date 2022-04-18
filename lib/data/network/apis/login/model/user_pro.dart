import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kimpro/data/network/apis/login/model/user.dart';

/// 전문가
class UserPro extends User{

  final busiName; // 상호명
  final repName; // 대표자명
  final busiNo; // 사업자번호
  final telNo; // 전화번호
  final busiAddr; // 사업장주소 (주소)
  final busiAddrDt; // 사업장 상세 주소 (주소)
  final busiFile; // 사업자등록증 (파일)

  UserPro({required id, required nickName, required isBusiness, required regDateTime,
    required this.busiName, required this.repName, required this.busiNo,
    required this.telNo, required this.busiAddr, required this.busiAddrDt, required this.busiFile})
      : super(id: id, nickName : nickName, isBusiness: isBusiness, regDateTime: regDateTime);

  /// firestore 저장시에 사용
  @override
  Map<String, Object> toJson() {
    return {
      UserProMapKey.id: id,
      UserProMapKey.nickName: nickName,
      UserProMapKey.isBusiness: isBusiness,
      UserProMapKey.regDateTime: regDateTime,
      UserProMapKey.busiName: busiName,
      UserProMapKey.repName: repName,
      UserProMapKey.busiNo: busiNo,
      UserProMapKey.telNo: telNo,
      UserProMapKey.busiAddr: busiAddr,
      UserProMapKey.busiAddrDt: busiAddrDt,
      UserProMapKey.busiFile: busiFile,
    };
  }

  /// firestore 에서 읽어들일 때 사용
  @override
  factory UserPro.fromJson(Map<String, dynamic>? json) {
    return UserPro(
      id: json![UserProMapKey.id],
      nickName: json[UserProMapKey.nickName],
      isBusiness: json[UserProMapKey.isBusiness],
      busiName: json[UserProMapKey.busiName],
      repName: json[UserProMapKey.repName],
      busiNo: json[UserProMapKey.busiNo],
      telNo: json[UserProMapKey.telNo],
      busiAddr: json[UserProMapKey.busiAddr],
      busiAddrDt: json[UserProMapKey.busiAddrDt],
      busiFile: json[UserProMapKey.busiFile],
      regDateTime:  (json[UserProMapKey.regDateTime] as Timestamp).toDate(),
    );
  }
}

class UserProMapKey extends UserMapKey {
  static const id = 'id';
  static const nickName = 'nickName';
  static const isBusiness = 'isBusiness';
  static const regDateTime = 'regDateTime';
  static const busiName = 'busiName';
  static const repName = 'repName';
  static const busiNo = 'busiNo';
  static const telNo = 'telNo';
  static const busiAddr = 'busiAddr';
  static const busiAddrDt = 'busiAddrDt';
  static const busiFile = 'busiFile';
}
