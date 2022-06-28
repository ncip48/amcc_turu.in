// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

class ImageDetail extends StatelessWidget {
  final String? image;

  ImageDetail({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(right: 10),
      height: MediaQuery.of(context).size.width * 0.95,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: Image.network(
          image!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
