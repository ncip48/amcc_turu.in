import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:turu_in/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

bool isDev = kDebugMode;
String urlHosts = isDev
    ? "http://192.168.18.33:2022"
    : "https://b1bb-118-99-83-92.ap.ngrok.io";
String urlHost = "https://b1bb-118-99-83-92.ap.ngrok.io";

getRequestAPI(String prefix, String method, Object? body, context) async {
  if (prefix == 'auth/login') {
    try {
      String url = urlHost;
      final response = await http.post(
        Uri.parse('$url/api/$prefix'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );
      if (response.statusCode == 200) {
        log('success fetch api $url/api/$prefix');
        Map<String, dynamic> map = json.decode(response.body);
        if (map['message'].toString().contains('Unauthorized')) {
          log('Unauthorized');
          return Navigator.of(context)
              .pushNamedAndRemoveUntil(Routes.Signin, (r) => false);
        }
        log(map['data'].toString());
        if (!map['success']) {
          if (map['data'] == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(map['message'].toString()),
              ),
            );
            return null;
          } else {
            log('username ~> ' + map['data']['email'].toString());
            if (map['data'].containsKey('email') &&
                map['data'].containsKey('password')) {
              var email = map['data']['email'][0].toString();
              var password = map['data']['password'][0].toString();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(email), Text(password)],
                  ),
                ),
              );
              return null;
            } else if (map['data'].containsKey('password')) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(map['data']['password'][0].toString()),
                ),
              );
              return null;
            } else if (map['data'].containsKey('email')) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(map['data']['email'][0].toString()),
                ),
              );
              return null;
            }
          }
        } else {
          return map['data'];
        }
      } else {
        log(response.body);
        log('failed to fetch api $url/api/$prefix');
      }
    } catch (exception) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exception.toString()),
        ),
      );
    }
  } else {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var getPrefs = prefs.getString('user');
      Map<String?, dynamic> map = json.decode(getPrefs!);
      var token = map['token'];
      String url = urlHost;
      switch (method) {
        case 'post':
          final response = await http.post(
            Uri.parse('$url/api/$prefix'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: body,
          );
          if (response.statusCode == 200) {
            log('success fetch api $url/api/$prefix');
            Map<String, dynamic> map = json.decode(response.body);
            if (map['message'].toString().contains('Unauthorized')) {
              log('Unauthorized');
              prefs.remove('user');
              return Navigator.of(context)
                  .pushNamedAndRemoveUntil(Routes.Signin, (r) => false);
            }
            log(map['message'].toString());
            if (!map['success']) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(map['message'].toString()),
                ),
              );
              return null;
            }
            return map['data'];
          } else {
            log(response.body);
            log('failed to fetch api $url/api/$prefix');
          }
          break;
        case 'patch':
          final response = await http.patch(
            Uri.parse('$url/api/$prefix'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: body,
          );
          if (response.statusCode == 200) {
            log('success fetch api $url/api/$prefix');
            Map<String, dynamic> map = json.decode(response.body);
            if (map['message'].toString().contains('Unauthorized')) {
              log('Unauthorized');
              prefs.remove('user');
              return Navigator.of(context)
                  .pushNamedAndRemoveUntil(Routes.Signin, (r) => false);
            }
            return map['data'];
          } else {
            log(response.body);
            log('failed fetch api $url/api/$prefix');
          }
          break;
        case 'get':
          final Map<String, String> headersData = {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          };
          final response = await http.get(
            Uri.parse('$url/api/$prefix'),
            headers: headersData,
          );
          log('headers ~> ' + headersData.toString());
          if (response.statusCode == 200) {
            log('success fetch api $url/api/$prefix');
            Map<String, dynamic> map = json.decode(response.body);
            if (map['message'].toString().contains('Unauthorized')) {
              log('Unauthorized');
              prefs.remove('user');
              return Navigator.of(context).pushReplacementNamed(Routes.Signin);
            }
            return map['data'];
          } else {
            log(response.body);
            log('failed fetch api $url/api/$prefix');
          }
          break;
        default:
      }
    } catch (exception) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(exception.toString()),
        ),
      );
    }
  }
}

getFormatedTime(_date) {
  DateTime x = DateTime.parse(_date);
  String date = DateFormat.Hm().format(x);
  return date;
}

String getMonth(int currentMonthIndex) {
  return DateFormat('MMM').format(DateTime(0, currentMonthIndex)).toString();
}

getTanggal(DateTime _date) {
  return DateFormat('d MMMM y', 'id_ID').format(_date);
}
