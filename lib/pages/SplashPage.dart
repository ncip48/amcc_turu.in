// ignore_for_file: file_names, prefer_const_constructors, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
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
  bool _isLogin;

  @override
  void initState() {
    super.initState();
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
    var user = prefs.getBool('login');
    setState(() {
      _isLogin = user != null ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4000,
      navigateAfterSeconds: SigninPage(),
      title: Text(
        'Turu.in',
        textScaleFactor: 2,
        style: GoogleFonts.robotoMono(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: CustomTheme().cookifyOnPrimary,
        ),
      ),
      image: Image.asset(
        'assets/logo.png',
        fit: BoxFit.contain,
        width: 100,
        height: 100,
      ),
      loadingText: Text(
        'v ${_version ?? '0.0.0+0'}',
        style: GoogleFonts.robotoMono(
          fontSize: 18,
          fontWeight: FontWeight.w300,
          color: CustomTheme().cookifyOnPrimary,
        ),
      ),
      photoSize: 100.0,
      backgroundColor: CustomTheme().turuInPrimary,
      useLoader: false,
    );
  }
}
