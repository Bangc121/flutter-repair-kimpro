import 'package:flutter/material.dart';
import 'package:kimpro/data/network/apis/login/user_api.dart';
import 'package:kimpro/stores/login/auth_provider.dart';
import 'package:kimpro/stores/login/user_provider.dart';
import 'package:kimpro/utils/logger/logger.dart';
import 'package:kimpro/utils/routes/routes.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthProvider authProvider;
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    userProvider = context.read<UserProvider>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 구글 로그인
  void _googleLogin() {
    authProvider.signInGoogle().then((fireBaseUser) => UserApi().findUserPro(fireBaseUser!.uid)).then((userAtDB) {
      if (userProvider.isChangeUser() || userAtDB == null) {
        Navigator.pushNamedAndRemoveUntil(context, Routes.addProfileSelect, (_) => false);
        userProvider.changeUser(false);
      } else {
        userProvider.setPrefUser(userAtDB);
        Navigator.pushNamedAndRemoveUntil(context, Routes.home, (_) => false);
      }
    });
  }

  /// 카카오 로그인
  void _kakaoLogin() {
    try {
      authProvider.signInKaKao().then((fireBaseUser) => UserApi().findUserPro(fireBaseUser!.uid)).then((userAtDB) {
        if (userProvider.isChangeUser() || userAtDB == null) {
          Navigator.pushNamedAndRemoveUntil(context, Routes.addProfileSelect, (_) => false);
          userProvider.changeUser(false);
        } else {
          userProvider.setPrefUser(userAtDB);
          Navigator.pushNamedAndRemoveUntil(context, Routes.home, (_) => false);
        }
      });
    } catch (error) {
      log.e('카카오톡으로 로그인 실패 $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('카카오톡으로 로그인 실패 $error'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: ListView(
            children: [
              // Align(
              //   child: TextButton(
              //       onPressed: () {
              //         log.i('둘러보기');
              //       },
              //       child: const Text('둘러보기')),
              //   alignment: Alignment.centerRight,
              // ),
              Container(
                alignment: Alignment.center,
                height: 400.0,
                child: const Text('logo'),
              ),
              ElevatedButton(
                  child: Text('카카오', style: Theme.of(context).textTheme.headline5),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFFFE600),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  onPressed: () => _kakaoLogin()),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                  child: Text('구글', style: Theme.of(context).textTheme.headline5),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  onPressed: () => _googleLogin())
            ],
          ),
        ),
      ),
    );
  }
}
