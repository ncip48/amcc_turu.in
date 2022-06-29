// ignore_for_file: file_names, deprecated_member_use

import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    final String encodedURl = Uri.encodeFull(googleUrl);
    await launch(encodedURl);
  }
}
