// ignore_for_file: file_names, prefer_const_constructors, unused_field, prefer_final_fields, non_constant_identifier_names, sized_box_for_whitespace, unnecessary_null_comparison, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:turu_in/model/Fasilitas.dart';
import 'package:turu_in/model/Hotel.dart';
import 'package:turu_in/routes/routes.dart';
import 'package:turu_in/theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:turu_in/utils/Currency.dart';
import 'package:turu_in/widget/MetodeBayar.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
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
  final Hotel prevState = Get.arguments;
  int _price = 0;
  int _durasi = 1;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    setState(() {
      _price = prevState.price!;
    });
  }

  Future<void> _selectDate(BuildContext context, int date) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: date == 0 ? _dateOneIso : _dateTwoIso,
      firstDate: DateTime.now().add(Duration(days: -365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (d != null)
      setState(() {
        if (date == 0) {
          _dateOne = DateFormat('d-M-y').format(d);
          _dateOneIso = d;
        } else {
          _dateTwo = DateFormat('d-M-y').format(d);
          _dateTwoIso = d;
        }
        var diff = _dateTwoIso.difference(_dateOneIso).inDays;
        var monthDiff = diff / 30;
        var month = monthDiff.ceil();
        var price = prevState.price! * month;
        _price = price;
        _durasi = month;
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
                      child: Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FxText.labelLarge(
                  prevState.name!,
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
                    top: 16,
                    bottom: 16,
                  ),
                  color: customTheme.turuInPrimary,
                  child: Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: MediaQuery.of(context).size.width / 1.93,
                          width: MediaQuery.of(context).size.width - 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            image: DecorationImage(
                              image: NetworkImage(
                                prevState.innerImage!,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                FxContainer(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 23,
                    right: 23,
                    bottom: 16,
                  ),
                  color: customTheme.turuInPrimary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          _selectDate(context, 0);
                        },
                        child: Row(
                          children: [
                            FxContainer(
                              height: 45,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              color: Color(0xff373D49),
                              child: Icon(
                                Icons.date_range,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                            FxContainer(
                              height: 45,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: customTheme.turuInSecondary,
                              child: FxText.labelMedium(
                                _dateOne,
                                color: Colors.white,
                                fontWeight: 600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.white,
                            ),
                            child: Divider(
                              color: Colors.white,
                              thickness: 1,
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          _selectDate(context, 1);
                        },
                        child: Row(
                          children: [
                            FxContainer(
                              height: 45,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              color: Color(0xff373D49),
                              child: Icon(
                                Icons.date_range,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                            FxContainer(
                              height: 45,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: customTheme.turuInSecondary,
                              child: FxText.labelMedium(
                                _dateTwo,
                                color: Colors.white,
                                fontWeight: 600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                FxContainer(
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 23,
                    right: 23,
                    bottom: 25,
                  ),
                  color: customTheme.turuInPrimary,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(right: 20.0),
                            child: Divider(
                              color: Colors.white,
                              height: 36,
                            )),
                      ),
                      FxText.labelMedium(
                        "bayar",
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(left: 20.0),
                            child: Divider(
                              color: Colors.white,
                              height: 36,
                            )),
                      ),
                    ],
                  ),
                ),
                MetodeBayar(
                  image: "assets/gojek.png",
                  value: 0,
                  groupValue: _value,
                  onChanged: (val) {
                    setState(() {
                      _value = val as int;
                    });
                  },
                  title: "Gopay",
                  status: true,
                  nominal: 550000,
                ),
                MetodeBayar(
                  image: "assets/dana.png",
                  value: 1,
                  groupValue: _value,
                  onChanged: (val) {
                    setState(() {
                      _value = val as int;
                    });
                  },
                  title: "Dana",
                  status: false,
                ),
                MetodeBayar(
                  image: "assets/ovo.png",
                  value: 2,
                  groupValue: _value,
                  onChanged: (val) {
                    setState(() {
                      _value = val as int;
                    });
                  },
                  title: "OVO",
                  status: true,
                  nominal: 0,
                ),
                MetodeBayar(
                  image: "assets/money.png",
                  value: 3,
                  groupValue: _value,
                  onChanged: (val) {
                    setState(() {
                      _value = val as int;
                    });
                  },
                  title: "Tunai",
                  status: false,
                ),
                const SizedBox(height: 10),
                FxContainer(
                  padding: const EdgeInsets.symmetric(horizontal: 27.0),
                  color: customTheme.turuInPrimary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FxText.labelMedium(
                            "Total",
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          Row(
                            children: [
                              FxText.labelMedium(
                                formatRupiah(_price),
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: 800,
                              ),
                              SizedBox(width: 5),
                              FxText.labelMedium(
                                '(${_durasi} bulan)',
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ],
                          ),
                        ],
                      ),
                      FxButton.rounded(
                        backgroundColor: customTheme.turuInTersier,
                        elevation: 0,
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.Booking);
                        },
                        child: FxText.labelMedium(
                          "Bayar",
                          color: Colors.white,
                          fontWeight: 600,
                          fontSize: 15,
                        ),
                      ),
                    ],
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
