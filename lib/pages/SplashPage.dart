// ignore_for_file: file_names, prefer_const_constructors, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:splashscreen/splashscreen.dart';
import 'package:turu_in/pages/HomePage.dart';
// import 'package:turu_in/pages/HomePage.dart';
import 'package:turu_in/pages/SigninPage.dart';
import 'package:turu_in/theme/app_theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late CustomTheme customTheme;
  late ThemeData theme;
  String? _version;
  bool _isLogin = false;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    _checkVersion();
    _checkLogin();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  Future<void> _checkVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String code = packageInfo.buildNumber;
    setState(() {
      _version = version + '+' + code;
    });
  }

  Future<void> _checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.getString('user');
    setState(() {
      _isLogin = user != null ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLogin ? HomePage() : SigninPage();
  }
}
