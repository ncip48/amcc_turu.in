// ignore_for_file: file_names, prefer_const_constructors, unused_field, prefer_final_fields, non_constant_identifier_names, sized_box_for_whitespace, unnecessary_null_comparison, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/flutx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turu_in/config/config.dart';
import 'package:turu_in/model/Booking.dart';
import 'package:turu_in/model/Fasilitas.dart';
import 'package:turu_in/model/User.dart';
import 'package:turu_in/routes/routes.dart';
import 'package:turu_in/theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:turu_in/widget/Empty.dart';
import 'package:turu_in/widget/ItemRiwayat.dart';
import 'package:turu_in/widget/Loading.dart';
import 'package:turu_in/widget/MenuEwallet.dart';
import 'package:turu_in/widget/MenuProfil.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({Key? key}) : super(key: key);

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage>
    with TickerProviderStateMixin {
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
  User _user = User();
  bool _isLoading = true;
  List<Booking> _bookings = [];

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _getUser();
  }

  Future<void> _getUser() async {
    setState(() {
      _isLoading = true;
    });
    final response = await getRequestAPI('bookings', 'get', null, context);
    log(response.toString());
    List<dynamic> values = response;
    List<Booking> _temp = [];
    if (values.isNotEmpty) {
      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          Map<String, dynamic> map = values[i];
          _temp.add(Booking.fromJson(map));
          // log('Id-------${map['id']}');
        }
      }
    }
    setState(() {
      _bookings = _temp;
      _isLoading = false;
    });
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
        child: _isLoading
            ? Loading()
            : Scaffold(
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
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
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
                            child:
                                Icon(Icons.arrow_back_ios, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      FxText.labelLarge(
                        "Riwayat",
                        color: Colors.white,
                        fontWeight: 800,
                        fontSize: 20,
                      )
                    ],
                  ),
                ),
                backgroundColor: customTheme.turuInPrimary,
                body: _bookings.isEmpty
                    ? Center(
                        child: Empty(
                          image:
                              "https://i.ibb.co/Qv54mFc/3973481-removebg-preview.png",
                          title: "Belum ada riwayat nih.",
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FxContainer(
                                padding: const EdgeInsets.only(
                                  top: 25,
                                  bottom: 16,
                                ),
                                color: customTheme.turuInPrimary,
                                child: SizedBox(
                                  child: ListView.builder(
                                    itemCount: _bookings.length,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    itemBuilder: (context, index) {
                                      var riwayat = _bookings[index];
                                      return ItemRiwayat(
                                        item: riwayat,
                                      );
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ),
              ),
      ),
    );
  }
}
