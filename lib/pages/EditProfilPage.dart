// ignore_for_file: file_names, prefer_const_constructors, unused_field, prefer_final_fields, non_constant_identifier_names, sized_box_for_whitespace, unnecessary_null_comparison, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/flutx.dart';
import 'package:turu_in/model/Fasilitas.dart';
import 'package:turu_in/theme/app_theme.dart';
import 'package:intl/intl.dart';

class EditProfilPage extends StatefulWidget {
  const EditProfilPage({Key? key}) : super(key: key);

  @override
  State<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage>
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
  String _dateOne = DateFormat('d MMMM y', 'id_ID').format(DateTime.now());
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
          _dateOne = DateFormat('d MMMM y', 'id_ID').format(d);
          _dateOneIso = d;
        } else {
          _dateTwo = DateFormat('d-M-y').format(d);
          _dateTwoIso = d;
        }
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
                  "Edit Profile",
                  color: Colors.white,
                  fontWeight: 800,
                  fontSize: 20,
                  textAlign: TextAlign.center,
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
                    top: 25,
                    bottom: 16,
                    left: 23,
                    right: 23,
                  ),
                  color: customTheme.turuInPrimary,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FxText.labelMedium(
                            "Email",
                            color: Colors.white,
                          ),
                          SizedBox(height: 5),
                          FxTextField(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            autoFocusedBorder: true,
                            textFieldStyle: FxTextFieldStyle.outlined,
                            textFieldType: FxTextFieldType.email,
                            filled: true,
                            fillColor: customTheme.turuInSecondary,
                            enabledBorderColor: customTheme.turuInSecondary,
                            focusedBorderColor: customTheme.turuInSecondary,
                            prefixIconColor: customTheme.cookifyOnPrimary,
                            labelTextColor: customTheme.cookifyOnPrimary,
                            cursorColor: customTheme.cookifyOnPrimary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                FxContainer(
                  padding: const EdgeInsets.only(
                    top: 0,
                    bottom: 16,
                    left: 23,
                    right: 23,
                  ),
                  color: customTheme.turuInPrimary,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FxText.labelMedium(
                            "Nama Lengkap",
                            color: Colors.white,
                          ),
                          SizedBox(height: 5),
                          FxTextField(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            autoFocusedBorder: true,
                            textFieldStyle: FxTextFieldStyle.outlined,
                            textFieldType: FxTextFieldType.name,
                            filled: true,
                            fillColor: customTheme.turuInSecondary,
                            enabledBorderColor: customTheme.turuInSecondary,
                            focusedBorderColor: customTheme.turuInSecondary,
                            prefixIconColor: customTheme.cookifyOnPrimary,
                            labelTextColor: customTheme.cookifyOnPrimary,
                            cursorColor: customTheme.cookifyOnPrimary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                FxContainer(
                  padding: const EdgeInsets.only(
                    top: 0,
                    bottom: 16,
                    left: 23,
                    right: 23,
                  ),
                  color: customTheme.turuInPrimary,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FxText.labelMedium(
                            "No HP",
                            color: Colors.white,
                          ),
                          SizedBox(height: 5),
                          FxTextField(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            autoFocusedBorder: true,
                            textFieldStyle: FxTextFieldStyle.outlined,
                            textFieldType: FxTextFieldType.mobileNumber,
                            filled: true,
                            fillColor: customTheme.turuInSecondary,
                            enabledBorderColor: customTheme.turuInSecondary,
                            focusedBorderColor: customTheme.turuInSecondary,
                            prefixIconColor: customTheme.cookifyOnPrimary,
                            labelTextColor: customTheme.cookifyOnPrimary,
                            cursorColor: customTheme.cookifyOnPrimary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                FxContainer(
                  padding: const EdgeInsets.only(
                    top: 0,
                    bottom: 16,
                    left: 23,
                    right: 23,
                  ),
                  color: customTheme.turuInPrimary,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FxText.labelMedium(
                            "Tanggal Lahir",
                            color: Colors.white,
                          ),
                          SizedBox(height: 5),
                          Row(
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
                                      width: MediaQuery.of(context).size.width /
                                          2.8,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      color: customTheme.turuInSecondary,
                                      child: Center(
                                        child: FxText.labelMedium(
                                          _dateOne,
                                          color: Colors.white,
                                          fontWeight: 600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: FxContainer(
                                  height: 45,
                                  width: MediaQuery.of(context).size.width / 3,
                                  borderRadius: BorderRadius.circular(10),
                                  color: customTheme.turuInSecondary,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FxText.labelMedium(
                                        "Pria",
                                        color: Colors.white,
                                      ),
                                      // const SizedBox(width: 10),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                FxContainer(
                  padding: const EdgeInsets.only(
                    top: 0,
                    bottom: 16,
                    left: 23,
                    right: 23,
                  ),
                  color: customTheme.turuInPrimary,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FxText.labelMedium(
                            "Alamat",
                            color: Colors.white,
                          ),
                          SizedBox(height: 5),
                          FxTextField(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            autoFocusedBorder: true,
                            textFieldStyle: FxTextFieldStyle.outlined,
                            textFieldType: FxTextFieldType.address,
                            filled: true,
                            fillColor: customTheme.turuInSecondary,
                            enabledBorderColor: customTheme.turuInSecondary,
                            focusedBorderColor: customTheme.turuInSecondary,
                            prefixIconColor: customTheme.cookifyOnPrimary,
                            labelTextColor: customTheme.cookifyOnPrimary,
                            cursorColor: customTheme.cookifyOnPrimary,
                          ),
                        ],
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
                        Navigator.pop(context);
                      },
                      child: FxText.labelMedium(
                        "Simpan",
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
