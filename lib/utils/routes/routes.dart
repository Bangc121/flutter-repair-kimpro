import 'package:kimpro/screens/bottomTab/bottomTab.dart';
import 'package:kimpro/screens/estimateDetail/estimateDetail.dart';
import 'package:kimpro/screens/home/home.dart';
import 'package:kimpro/screens/login/add_profile.dart';
import 'package:kimpro/screens/login/add_profile_pro.dart';
import 'package:kimpro/screens/login/add_profile_select.dart';
import 'package:kimpro/screens/login/login.dart';
import 'package:kimpro/screens/estimateInput/estimateInput.dart';
import 'package:kimpro/screens/login/splash.dart';
import 'package:kimpro/screens/scheduleInput/scheduleInput.dart';
import 'package:kimpro/screens/list/list.dart';
import 'package:kimpro/screens/totalService/totalService.dart';
import 'package:kimpro/screens/addressInput/addressInput.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String bottomTab = '/bottomTab';
  static const String home = '/home';
  static const String totalService = '/totalService';
  static const String addressInput = '/addressInput';
  static const String scheduleInput = '/scheduleInput';
  static const String estimateInput = '/estimateInput';
  static const String list = '/list';
  static const String estimateDetail = '/estimateDetail';
  static const String addProfileSelect = '/add-profile-select';
  static const String addProfile = '/add-profile';
  static const String addProfilePro = '/add-profile-pro';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    bottomTab: (BuildContext context) => BottomTabScreen(),
    home: (BuildContext context) => HomeScreen(),
    totalService: (BuildContext context) => TotalServiceScreen(),
    addressInput: (BuildContext context) => AddressInputScreen(),
    scheduleInput: (BuildContext context) => ScheduleInputScreen(),
    estimateInput: (BuildContext context) => EstimateInputScreen(),
    list: (BuildContext context) => ListScreen(),
    estimateDetail: (BuildContext context) => EstimateDetailScreen(),
    addProfileSelect: (BuildContext context) => AddProfileSelectScreen(),
    addProfile: (BuildContext context) => AddProfileScreen(),
    addProfilePro: (BuildContext context) => AddProfileProScreen(),
  };
}



