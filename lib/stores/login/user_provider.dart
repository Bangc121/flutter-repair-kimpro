import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kimpro/data/network/apis/login/model/user.dart';
import 'package:kimpro/data/network/apis/login/model/user_pro.dart';
import 'package:kimpro/data/network/apis/login/user_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  final SharedPreferences prefs;
  final FirebaseStorage firebaseStorage;

  UserProvider(this.prefs, this.firebaseStorage);

  /// db 에 사용자 저장 - sharedPref 에 사용자 저장
  Future<void> saveUserDB(String uid, String nickName) {
    User _dbUser = User(
      id: uid,
      nickName: nickName,
      isBusiness: false,
      regDateTime: DateTime.now(),
    );
    setPrefUser(_dbUser);
    return UserApi().saveUser(_dbUser);
  }

  Future<void> saveUserProDB(String uid, String nickName, busiName, repName, busiNo, telNo, busiAddr, busiAddrDt, busiFile) {
    UserPro _dbUser = UserPro(
      id: uid,
      nickName: nickName,
      isBusiness: true,
      regDateTime: DateTime.now(),
      busiName: busiName,
      repName: repName,
      busiNo: busiNo,
      telNo: telNo,
      busiAddr: busiAddr,
      busiAddrDt: busiAddrDt,
      busiFile: busiFile,
    );
    setPrefUserPro(_dbUser);

    return UserApi().saveUser(_dbUser);
  }

  Future<bool> isExistUser(String id) {
    return UserApi().isExists(id);
  }

  /// 사용자 전환 여부
  bool isChangeUser(){
    return prefs.getBool('changeUser') == true;
  }

  /// 사용자 전환
  void changeUser(bool changeUser){
    prefs.setBool('changeUser', changeUser);
  }

  /// 사용자정보 local 저장
  void setPrefUser(User user) {
    prefs.setString(UserMapKey.id, user.id);
    prefs.setString(UserMapKey.nickName, user.nickName);
    prefs.setBool(UserMapKey.isBusiness, user.isBusiness);
    prefs.setInt(UserMapKey.regDateTime, (user.regDateTime as DateTime).millisecondsSinceEpoch);
  }

  void setPrefUserPro(UserPro userPro) {
    prefs.setString(UserProMapKey.id, userPro.id);
    prefs.setString(UserProMapKey.nickName, userPro.nickName);
    prefs.setBool(UserProMapKey.isBusiness, userPro.isBusiness);
    prefs.setInt(UserProMapKey.regDateTime, (userPro.regDateTime as DateTime).millisecondsSinceEpoch);
    prefs.setString(UserProMapKey.busiName, userPro.busiName);
    prefs.setString(UserProMapKey.repName, userPro.repName);
    prefs.setString(UserProMapKey.busiNo, userPro.busiNo);
    prefs.setString(UserProMapKey.telNo, userPro.telNo);
    prefs.setString(UserProMapKey.busiAddr, userPro.busiAddr);
    prefs.setString(UserProMapKey.busiFile, userPro.busiFile);
  }

  Map<String, Object?> getPrefUser() {
    if(prefs.getBool(UserMapKey.isBusiness) == true) {
      return {
        UserProMapKey.id: prefs.getString(UserMapKey.id),
        UserProMapKey.nickName: prefs.getString(UserMapKey.nickName),
        UserProMapKey.isBusiness: prefs.getBool(UserMapKey.isBusiness),
        UserProMapKey.regDateTime: DateTime.fromMillisecondsSinceEpoch(prefs.getInt(UserMapKey.regDateTime)!),
        UserProMapKey.busiName: prefs.getString(UserProMapKey.busiName),
        UserProMapKey.repName: prefs.getString(UserProMapKey.repName),
        UserProMapKey.busiNo: prefs.getString(UserProMapKey.busiNo),
        UserProMapKey.telNo: prefs.getString(UserProMapKey.telNo),
        UserProMapKey.busiAddr: prefs.getString(UserProMapKey.busiAddr),
        UserProMapKey.busiFile: prefs.getString(UserProMapKey.busiFile),
      };
    }else{
      return {
        UserMapKey.id: prefs.getString(UserMapKey.id),
        UserMapKey.nickName: prefs.getString(UserMapKey.nickName),
        UserMapKey.isBusiness: prefs.getBool(UserMapKey.isBusiness),
        UserMapKey.regDateTime: DateTime.fromMillisecondsSinceEpoch(prefs.getInt(UserMapKey.regDateTime)!) ,
      };
    }
  }

  /// 파일 업로드
  UploadTask uploadFile(File image, String folderName, String fileName) {
    Reference reference = firebaseStorage.ref().child(folderName).child(fileName);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }
}
