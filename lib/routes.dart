import 'package:flutter/widgets.dart';

class AppRoutes {
  static String homePage ='/';
  static String newsNetailPage ='/news';
  static String reduxPage = '/redux';
  static String userPage = '/user';
}

class AppRouteKeys {
  static final Key homePage = Key('__homePageKey__');
  static final Key userPage = Key('__userPageKey__');
  static final Key reduxPage = Key('__reduxPageKey__');
  static final Key newsNetailPage = Key('__newsNetailPageKey__');
}