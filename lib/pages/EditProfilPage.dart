// ignore_for_file: file_names, prefer_const_constructors, prefer_final_fields, non_constant_identifier_names, sized_box_for_whitespace, unnecessary_null_comparison, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/flutx.dart';
import 'package:turu_in/config/config.dart';
import 'package:turu_in/model/User.dart';
import 'package:turu_in/theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:turu_in/widget/Loading.dart';

class EditProfilPage extends StatefulWidget {
  const EditProfilPage({Key? key}) : super(key: key);

  @override
  State<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage>
    with TickerProviderStateMixin {
  late CustomTheme customTheme;
  late ThemeData theme;
  String _dateOne = DateFormat('d MMMM y', 'id_ID').format(DateTime.now());
  DateTime _dateOneIso = DateTime.now();
  bool _isLoading = true;
  bool _isLoadingSave = false;
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerNoHp = TextEditingController();
  TextEditingController _controllerAlamat = TextEditingController();
  int _gender = 0;

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
    final response = await getRequestAPI('profile', 'get', null, context);
    log(response.toString());
    User _userDetail = User.fromJson(response);

    setState(() {
      _controllerEmail.text = _userDetail.email!;
      _controllerNama.text = _userDetail.name!;
      _controllerNoHp.text = _userDetail.phone!;
      _controllerAlamat.text = _userDetail.address!;
      _gender = _userDetail.gender!;
      _dateOne = DateFormat('d MMMM y', 'id_ID')
          .format(DateTime.parse(_userDetail.dob!));
      _dateOneIso = DateTime.parse(_userDetail.dob!);
      _isLoading = false;
    });
  }

  Future<void> _saveAction() async {
    setState(() {
      _isLoadingSave = true;
    });
    log(_controllerEmail.text);
    // final response = await getRequestAPI('profile', 'patch', null, context);
    // log(response.toString());
    // User _userDetail = User.fromJson(response);

    setState(() {
      // _controllerEmail.text = _userDetail.email!;
      // _controllerNama.text = _userDetail.name!;
      // _controllerNoHp.text = _userDetail.phone!;
      // _controllerAlamat.text = _userDetail.address!;
      // _gender = _userDetail.gender!;
      // _dateOne = DateFormat('d MMMM y', 'id_ID')
      //     .format(DateTime.parse(_userDetail.dob!));
      // _dateOneIso = DateTime.parse(_userDetail.dob!);
      _isLoadingSave = false;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: _dateOneIso,
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (d != null)
      setState(() {
        _dateOne = DateFormat('d MMMM y', 'id_ID').format(d);
        _dateOneIso = d;
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
                                  controller: _controllerEmail,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  autoFocusedBorder: true,
                                  textFieldStyle: FxTextFieldStyle.outlined,
                                  textFieldType: FxTextFieldType.email,
                                  filled: true,
                                  fillColor: customTheme.turuInSecondary,
                                  enabledBorderColor:
                                      customTheme.turuInSecondary,
                                  focusedBorderColor:
                                      customTheme.turuInSecondary,
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
                                  controller: _controllerNama,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  autoFocusedBorder: true,
                                  textFieldStyle: FxTextFieldStyle.outlined,
                                  textFieldType: FxTextFieldType.name,
                                  filled: true,
                                  fillColor: customTheme.turuInSecondary,
                                  enabledBorderColor:
                                      customTheme.turuInSecondary,
                                  focusedBorderColor:
                                      customTheme.turuInSecondary,
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
                                  controller: _controllerNoHp,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  autoFocusedBorder: true,
                                  textFieldStyle: FxTextFieldStyle.outlined,
                                  textFieldType: FxTextFieldType.mobileNumber,
                                  filled: true,
                                  fillColor: customTheme.turuInSecondary,
                                  enabledBorderColor:
                                      customTheme.turuInSecondary,
                                  focusedBorderColor:
                                      customTheme.turuInSecondary,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _selectDate(context);
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
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
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
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
                                              _gender == 1 ? "Pria" : "Wanita",
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
                                  controller: _controllerAlamat,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  autoFocusedBorder: true,
                                  textFieldStyle: FxTextFieldStyle.outlined,
                                  textFieldType: FxTextFieldType.address,
                                  filled: true,
                                  fillColor: customTheme.turuInSecondary,
                                  enabledBorderColor:
                                      customTheme.turuInSecondary,
                                  focusedBorderColor:
                                      customTheme.turuInSecondary,
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
                              _isLoadingSave ? null : _saveAction();
                            },
                            child: _isLoadingSave
                                ? SizedBox(
                                    child: CircularProgressIndicator(
                                      color: CustomTheme().cookifyOnPrimary,
                                    ),
                                    height: 15,
                                    width: 15,
                                  )
                                : FxText.labelMedium(
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
