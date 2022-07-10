// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turu_in/theme/app_theme.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: CircularProgressIndicator(
                  color: CustomTheme().turuInPrimary,
                ),
                height: 25,
                width: 25,
              ),
              SizedBox(height: 10),
              Text(
                'Tunggu...',
                style: GoogleFonts.poppins(
                  color: CustomTheme().turuInPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
