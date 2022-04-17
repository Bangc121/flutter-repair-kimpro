import 'dart:async';

import 'package:kimpro/constants/assets.dart';
import 'package:kimpro/data/sharedpref/constants/preferences.dart';
import 'package:kimpro/utils/routes/routes.dart';
import 'package:kimpro/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {

    return Material(
      child: Center(child: AppIconWidget(image: Assets.appLogo)),
    );
  }

  startTimer() {
    var _duration = Duration(milliseconds: 3000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getBool(Preferences.is_logged_in) ?? false) {
      Navigator.of(context).pushReplacementNamed(Routes.bottomTab);
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.login);
    }
  }
}
