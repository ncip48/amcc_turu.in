// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, sized_box_for_whitespace, unnecessary_null_comparison, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:turu_in/theme/app_theme.dart';
import 'package:turu_in/utils/Currency.dart';

class MetodeBayar extends StatelessWidget {
  final String image;
  final int value;
  final int groupValue;
  final void Function(int?)? onChanged;
  final String title;
  final bool status;
  int? nominal = 0;

  MetodeBayar(
      {Key? key,
      required this.image,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      required this.title,
      required this.status,
      this.nominal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        //here change to your color
        unselectedWidgetColor: CustomTheme().turuInPrimary,
      ),
      child: FxContainer(
        padding: const EdgeInsets.only(
          top: 5,
          left: 23,
          right: 23,
          bottom: 5,
        ),
        color: CustomTheme().turuInPrimary,
        child: Card(
          elevation: 0,
          color: CustomTheme().turuInSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Radio(
                      value: value,
                      groupValue: groupValue,
                      onChanged: onChanged,
                      toggleable: true,
                      activeColor: CustomTheme().turuInTersier,
                    ),
                    Row(
                      children: [
                        Image(
                          image: AssetImage(
                            image,
                          ),
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(width: 10),
                        FxText.labelMedium(
                          title,
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ],
                    ),
                  ],
                ),
                if (value != 3)
                  FxText.labelMedium(
                    status ? formatRupiah(nominal!) : "Hubungkan",
                    color: status ? Colors.white : CustomTheme().turuInTersier,
                    fontSize: 12,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
