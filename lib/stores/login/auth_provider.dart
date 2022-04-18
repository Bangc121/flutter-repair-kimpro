import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:kimpro/data/network/apis/login/kakao_verify_api.dart';
import 'package:kimpro/utils/logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateCanceled,
}

class AuthProvider {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final SharedPreferences prefs;

  Status _status = Status.uninitialized;

  Status get status => _status;

  //FirebaseAuth instance
  AuthProvider(this._firebaseAuth, this._googleSignIn, this.prefs);

  //Using Stream to listen to Authentication State
  Stream<User?> get authState => _firebaseAuth.authStateChanges();

  //SIGN OUT METHOD
  Future<void> signOut() async {
    _status = Status.uninitialized;
    bool isGoogle = await _googleSignIn.isSignedIn();
    if(isGoogle) {
      await _googleSignIn.signOut();
    }
    await _firebaseAuth.signOut();
  }

  /// 카카오 인증
  Future<User?> signInKaKao() async {
    kakao.OAuthToken token = await kakao.UserApi.instance.loginWithKakaoTalk();
    log.d('카카오톡으로 로그인 및 카카오 토큰 발급 성공: $token');
    Map customToken = await KVerifyApi().verifyToken({'token': token.accessToken});
    log.d('firebase 계정생성 및 커스텀 토큰 발급 성공: $customToken');
    UserCredential uc = await _firebaseAuth.signInWithCustomToken(customToken['firebase_token']);
    return uc.user;
  }

  /// 구글 로그인
  Future<User?> signInGoogle() async {
    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth?.idToken,
      accessToken: googleAuth?.accessToken,
    );
    UserCredential uc = await _firebaseAuth.signInWithCredential(credential);
    return uc.user;
  }

  Future<bool> isLoggedIn() async {
    bool isLoggedIn = _firebaseAuth.currentUser != null;
    if (isLoggedIn && prefs.getString('id')?.isNotEmpty == true) {
      return true;
    } else {
      return false;
    }
  }

  /// 닉네임 업데이트
  Future updateProfile(String nickName) {
    return _firebaseAuth.currentUser!.updateDisplayName(nickName);
  }
}
