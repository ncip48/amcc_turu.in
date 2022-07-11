// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, sized_box_for_whitespace, avoid_print, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutx/widgets/widgets.dart';

class Empty extends StatelessWidget {
  final String image;
  final String title;

  Empty({required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: image,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.width * 0.5,
          ),
          SizedBox(height: 10.0),
          Align(
              alignment: Alignment.center,
              child: FxText.labelLarge(
                title,
                color: Colors.white,
                fontSize: 20,
              )),
        ],
      ),
    );
  }
}
