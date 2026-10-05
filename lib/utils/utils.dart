import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Future<bool> lauchURl(String code) async {
    final uri = Uri.tryParse(code);
    if (uri != null && await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    } else {
      return false;
    }
  }

  static void showSnackBarWith(
      BuildContext context, String msg, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 3.0,
      duration: const Duration(milliseconds: 600),
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).cardColor,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(msg),
          ),
        ],
      ),
    ));
  }
}
