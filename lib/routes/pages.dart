// ignore_for_file: constant_identifier_names, prefer_const_constructors

import 'package:get/get.dart';
import 'package:turu_in/pages/BookingPage.dart';
import 'package:turu_in/pages/DetailPage.dart';
import 'package:turu_in/pages/EditProfilPage.dart';
import 'package:turu_in/pages/HomePage.dart';
import 'package:turu_in/pages/ProfilPage.dart';
import 'package:turu_in/pages/SigninPage.dart';
import 'package:turu_in/pages/SignupPage.dart';
import 'package:turu_in/pages/SplashPage.dart';
import 'package:turu_in/routes/routes.dart';

class AppPages {
  static const Initial = Routes.Root;

  static final routes = [
    GetPage(name: Routes.Root, page: () => SplashPage()),
    GetPage(name: Routes.Home, page: () => HomePage()),
    GetPage(name: Routes.Signin, page: () => SigninPage()),
    GetPage(name: Routes.Signup, page: () => SignupPage()),
    GetPage(name: Routes.Detail, page: () => DetailPage()),
    GetPage(name: Routes.Booking, page: () => BookingPage()),
    GetPage(name: Routes.Profil, page: () => ProfilPage()),
    GetPage(name: Routes.EditProfil, page: () => EditProfilPage()),
  ];
}
