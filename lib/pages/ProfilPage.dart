// ignore_for_file: file_names, prefer_const_constructors, unused_field, prefer_final_fields, non_constant_identifier_names, sized_box_for_whitespace, unnecessary_null_comparison, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/flutx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turu_in/model/Fasilitas.dart';
import 'package:turu_in/routes/routes.dart';
import 'package:turu_in/theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:turu_in/widget/MenuEwallet.dart';
import 'package:turu_in/widget/MenuProfil.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> with TickerProviderStateMixin {
  late CustomTheme customTheme;
  late ThemeData theme;
  PageController _pageController = PageController(
    initialPage: 0,
  );
  Fasilitas _fasilitas = Fasilitas(
    wifi: "10",
    room: "3 x 3",
    gender: "male",
    bathroom: "outside",
  );
  String _dateOne = DateFormat('d-M-y').format(DateTime.now());
  DateTime _dateOneIso = DateTime.now();
  String _dateTwo = DateFormat('d-M-y').format(DateTime.now());
  DateTime _dateTwoIso = DateTime.now();
  int _value = 0;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    Navigator.of(context).pushNamedAndRemoveUntil(Routes.Signin, (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    log((MediaQuery.of(context).size.width / 4).toString());
    return Theme(
      data: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          secondary: customTheme.turuInPrimary.withAlpha(40),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: customTheme.turuInPrimary,
              // Status bar brightness (optional)
              statusBarIconBrightness: Brightness.light,
            ),
            backgroundColor: customTheme.turuInPrimary,
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: MediaQuery.of(context).size.width / 6,
            title: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 44,
                    width: 44,
                    margin: EdgeInsets.only(left: 5, top: 10, bottom: 10),
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Color.fromRGBO(255, 255, 255, 0.45),
                    ),
                    child: Center(
                      child: Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FxText.labelLarge(
                  "Profile",
                  color: Colors.white,
                  fontWeight: 800,
                  fontSize: 20,
                )
              ],
            ),
          ),
          backgroundColor: customTheme.turuInPrimary,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxContainer(
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 16,
                  ),
                  color: customTheme.turuInPrimary,
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.width / 3.5,
                      width: MediaQuery.of(context).size.width / 3.5,
                      alignment: Alignment.bottomRight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width / 2.5,
                        ),
                        color: Colors.white,
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://media-exp2.licdn.com/dms/image/C5603AQGJgwZuQ3sUMQ/profile-displayphoto-shrink_800_800/0/1601275519734?e=1661990400&v=beta&t=AdTqkzPUK7PMBS8ExaV2pT7e97GzFLEFOkrrbEpmUmU",
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: customTheme.turuInSecondary,
                            borderRadius: BorderRadius.circular(100)),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                FxContainer(
                  padding: const EdgeInsets.only(
                    top: 25,
                    bottom: 16,
                  ),
                  color: customTheme.turuInPrimary,
                  child: Center(
                    child: FxText.titleLarge(
                      "Herly Chahya Putra",
                      fontSize: 24,
                      fontWeight: 600,
                      color: Colors.white,
                    ),
                  ),
                ),
                FxContainer(
                  padding: const EdgeInsets.only(
                    top: 25,
                    bottom: 16,
                  ),
                  color: customTheme.turuInPrimary,
                  child: Column(
                    children: [
                      MenuProfil(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.EditProfil);
                        },
                        title: "Edit Profil",
                        top: true,
                        bottom: false,
                      ),
                      MenuProfil(
                        onTap: () {},
                        title: "Riwayat",
                        top: false,
                        bottom: false,
                      ),
                      MenuProfil(
                        onTap: () {},
                        title: "Pesan",
                        top: false,
                        bottom: true,
                      ),
                    ],
                  ),
                ),
                FxContainer(
                  padding: const EdgeInsets.only(
                    top: 16,
                    bottom: 16,
                  ),
                  color: customTheme.turuInPrimary,
                  child: Column(
                    children: [
                      MenuEwallet(
                        onTap: () {},
                        title: "Gopay",
                        top: true,
                        bottom: false,
                        connected: true,
                        image: "assets/gojek.png",
                      ),
                      MenuEwallet(
                        onTap: () {},
                        title: "Dana",
                        top: false,
                        bottom: false,
                        connected: false,
                        image: "assets/dana.png",
                      ),
                      MenuEwallet(
                        onTap: () {},
                        title: "Ovo",
                        top: false,
                        bottom: true,
                        connected: true,
                        image: "assets/ovo.png",
                      ),
                    ],
                  ),
                ),
                Center(
                  child: FxContainer(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 27.0,
                      vertical: 15,
                    ),
                    color: customTheme.turuInPrimary,
                    child: FxButton.rounded(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 70,
                        vertical: 11,
                      ),
                      backgroundColor: customTheme.turuInTersier,
                      elevation: 0,
                      onPressed: () {
                        _logout();
                      },
                      child: FxText.labelMedium(
                        "Logout",
                        color: Colors.white,
                        fontWeight: 600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
