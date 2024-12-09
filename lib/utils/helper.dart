import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';

class Helper {
  static bool checkConnectionError(e) {
    if (e.toString().contains('SocketException') ||
        e.toString().contains('HandshakeException')) {
      return true;
    } else {
      return false;
    }
  }

  bool isUnauthorizedAccess(int status) {
    return status == HTTPStatus.httpUnauthorizedCode ||
        status == HTTPStatus.httpForbiddenCode;
  }

  Future<void> launchInBrowser(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  String mapToQueryString(Map<String, dynamic> params) {
    return Uri(queryParameters: params).query;
  }

  Future<void> copyToClipboard(BuildContext context, String text,
      String successMsg, String errorMsg) async {
    await Clipboard.setData(ClipboardData(text: text))
        .then((value) => showSnackBar(
              context,
              successMsg,
              Colors.green,
            ))
        .catchError((error) => showSnackBar(
              context,
              errorMsg,
              Colors.red,
            ));
  }

  bool isNullEmptyOrFalse(dynamic value) {
    if (value == null || value == '' || value == false) {
      return true;
    } else {
      return false;
    }
  }

  String formatDateTime(String dateTime) {
    return DateFormat('MMM d, y h:mm a').format(DateTime.parse(dateTime));
  }

  String formatDate(String date) {
    return DateFormat('MMM d, y').format(DateTime.parse(date));
  }

  String formatMonthYear(String date) {
    return DateFormat('MMM y').format(DateTime.parse(date));
  }

  String formatTimeShort(String time) {
    return DateFormat('h:mm a').format(DateTime.parse(time));
  }

  void showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: color,
      ),
    );
  }

  void navigateAndClearStack(BuildContext context, String route) {
    Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
  }
}
