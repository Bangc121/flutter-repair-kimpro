import 'package:kimpro/ui/bottomTab/bottomTab.dart';
import 'package:kimpro/ui/estimateDetail/estimateDetail.dart';
import 'package:kimpro/ui/home/home.dart';
import 'package:kimpro/ui/login/login.dart';
import 'package:kimpro/ui/estimateInput/estimateInput.dart';
import 'package:kimpro/ui/scheduleInput/scheduleInput.dart';
import 'package:kimpro/ui/splash/splash.dart';
import 'package:kimpro/ui/list/list.dart';
import 'package:kimpro/ui/totalService/totalService.dart';
import 'package:kimpro/ui/addressInput/addressInput.dart';
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
    estimateDetail: (BuildContext context) => EstimateDetailScreen()
  };
}



