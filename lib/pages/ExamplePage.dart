// ignore_for_file: file_names, unnecessary_string_escapes

import 'package:turu_in/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme.copyWith(
          colorScheme: theme.colorScheme
              .copyWith(secondary: customTheme.turuInPrimary.withAlpha(40))),
      child: Scaffold(
        body: ListView(
          padding: FxSpacing.fromLTRB(24, 100, 24, 0),
          children: [
            FxTwoToneIcon(
              FxTwoToneMdiIcons.menu_book,
              color: customTheme.cookifyPrimary,
              size: 64,
            ),
            FxSpacing.height(16),
            Center(
              child: FxText.headlineSmall("Log In",
                  color: customTheme.cookifyPrimary, fontWeight: 800),
            ),
            FxSpacing.height(32),
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
            FxSpacing.height(24),
            FxTextField(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              autoFocusedBorder: true,
              textFieldStyle: FxTextFieldStyle.outlined,
              textFieldType: FxTextFieldType.password,
              filled: true,
              fillColor: customTheme.cookifyPrimary.withAlpha(40),
              enabledBorderColor: customTheme.cookifyPrimary,
              focusedBorderColor: customTheme.cookifyPrimary,
              prefixIconColor: customTheme.cookifyPrimary,
              labelTextColor: customTheme.cookifyPrimary,
              cursorColor: customTheme.cookifyPrimary,
            ),
            FxSpacing.height(16),
            Align(
              alignment: Alignment.centerRight,
              child: FxButton.text(
                  onPressed: () {},
                  padding: FxSpacing.zero,
                  splashColor: customTheme.cookifyPrimary.withAlpha(40),
                  child: FxText.labelMedium("Forgot Password?",
                      color: customTheme.cookifyPrimary)),
            ),
            FxSpacing.height(16),
            FxButton.block(
                borderRadiusAll: 8,
                onPressed: () {},
                backgroundColor: customTheme.turuInTersier,
                child: FxText.labelLarge(
                  "Log In",
                  color: customTheme.cookifyOnPrimary,
                )),
            FxSpacing.height(16),
            FxButton.text(
                onPressed: () {},
                splashColor: customTheme.cookifyPrimary.withAlpha(40),
                child: FxText.labelMedium("I haven\'t an account",
                    decoration: TextDecoration.underline,
                    color: customTheme.cookifyPrimary))
          ],
        ),
      ),
    );
  }
}
