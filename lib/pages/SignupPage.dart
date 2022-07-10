// ignore_for_file: unused_field, prefer_final_fields, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _secureText1 = false;
  bool _secureText2 = false;
  bool isChecked = false;
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
            height: mainSize.height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 48, left: 49),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sign Up',
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
                      borderRadius: BorderRadius.circular(10))),
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
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, right: 48, left: 49),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Confirm Password',
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
              obscureText: _secureText2,
              decoration: InputDecoration(
                  fillColor: Color(0xff3E4553),
                  filled: true,
                  hintText: 'Masukkan password..',
                  hintStyle: GoogleFonts.openSans(color: Color(0xff6F7075)),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _secureText2 = !_secureText2;
                      });
                    },
                    icon: Icon(_secureText2
                        ? Icons.visibility
                        : Icons.visibility_off_rounded),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          SizedBox(height: mainSize.height * 0.07),
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
                  onPressed: () {},
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  )))
        ],
      ),
    );
  }
}
