import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  /// Returns a [Uri] only for plain web links (http/https).
  ///
  /// Scanned QR payloads are untrusted input: they must never be able to
  /// trigger arbitrary URI schemes (`tel:`, `sms:`, `intent:`, `file:` ...).
  static Uri? safeWebUri(String code) {
    final uri = Uri.tryParse(code.trim());
    if (uri == null || !uri.hasAuthority || uri.host.isEmpty) return null;
    if (uri.scheme != 'http' && uri.scheme != 'https') return null;
    return uri;
  }

  static Future<bool> lauchURl(String code) async {
    final uri = safeWebUri(code);
    if (uri == null) return false;
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
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
