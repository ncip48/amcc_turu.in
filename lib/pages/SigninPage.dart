// ignore_for_file: unused_field, prefer_final_fields, prefer_const_constructors, file_names

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turu_in/config/config.dart';
import 'package:turu_in/model/Auth.dart';
import 'package:turu_in/routes/routes.dart';
import 'package:turu_in/theme/app_theme.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool _secureText1 = false;
  bool _secureText2 = false;
  bool isChecked = false;
  bool _isLoading = false;
  String _email = '';
  String _password = '';

  Future<void> _actionLogin() async {
    FocusManager.instance.primaryFocus!.unfocus();
    setState(() {
      _isLoading = true;
    });
    var body =
        jsonEncode(<String, String>{'email': _email, 'password': _password});
    final response = await getRequestAPI('auth/login', 'post', body, context);
    log('response ~> ' + response.toString());
    if (response != null) {
      Auth auth = Auth.fromJson(response);
      _savePreferences(auth);
      Navigator.of(context).pushReplacementNamed(Routes.Home);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _savePreferences(Auth user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(user));
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveState = <MaterialState>{
        MaterialState.hovered,
        MaterialState.pressed,
        MaterialState.focused,
      };
      if (states.any(interactiveState.contains)) {
        return Colors.black;
      }
      return Color(0xffFF7360);
    }

    Size mainSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff313642),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 111),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.bed,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                Text('Turu.in',
                    style: GoogleFonts.robotoMono(
                        fontSize: 37,
                        fontWeight: FontWeight.w400,
                        color: Colors.white))
              ],
            ),
          ),
          SizedBox(
            height: mainSize.height * 0.075,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 48, left: 49),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Login',
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            height: mainSize.height * 0.025,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 48, left: 49),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Email',
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, right: 48, left: 49),
            child: TextField(
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
              decoration: InputDecoration(
                fillColor: Color(0xff3E4553),
                filled: true,
                hintText: 'Masukkan email..',
                hintStyle: GoogleFonts.openSans(color: Color(0xff6F7075)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                _email = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, right: 48, left: 49),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Password',
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, right: 48, left: 49),
            child: TextField(
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
              obscureText: _secureText1,
              decoration: InputDecoration(
                fillColor: Color(0xff3E4553),
                filled: true,
                hintText: 'Masukkan password..',
                hintStyle: GoogleFonts.openSans(color: Color(0xff6F7075)),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _secureText1 = !_secureText1;
                    });
                  },
                  icon: Icon(_secureText1
                      ? Icons.visibility
                      : Icons.visibility_off_rounded),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                _password = value;
              },
            ),
          ),
          SizedBox(height: mainSize.height * 0.015),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 42.0),
                child: Checkbox(
                    value: isChecked,
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    }),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Syarat & Ketentuan',
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: Color(0xffFF7360)),
                  )),
            ],
          ),
          Container(
              width: 194,
              height: 45,
              decoration: BoxDecoration(
                  color: Color(0xffFF7360),
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                  onPressed: () {
                    _isLoading ? null : _actionLogin();
                  },
                  child: _isLoading
                      ? SizedBox(
                          child: CircularProgressIndicator(
                            color: CustomTheme().cookifyOnPrimary,
                          ),
                          height: 15,
                          width: 15,
                        )
                      : Text(
                          'Login',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ))),
          SizedBox(
            height: mainSize.height * 0.024,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 2,
                width: 118,
                color: Colors.white,
              ),
              Text(
                'atau',
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Container(
                height: 2,
                width: 118,
                color: Colors.white,
              ),
            ],
          ),
          SizedBox(
            height: mainSize.height * 0.028,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 55.0),
                child: Container(
                  height: 36,
                  width: 118,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/google.png',
                        width: 22,
                        height: 22,
                      ),
                      Text(
                        'Google',
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 36,
                width: 118,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/facebook.png',
                      width: 22,
                      height: 22,
                    ),
                    Text(
                      'Facebook',
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: mainSize.height * 0.024,
          ),
          Container(
              width: 194,
              height: 45,
              decoration: BoxDecoration(
                  color: Color(0xffFF7360),
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.Signup);
                  },
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ))),
        ],
      ),
    );
  }
}
