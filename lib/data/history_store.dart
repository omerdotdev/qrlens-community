import 'dart:convert';

import 'package:qrlens_community/data/models/qrcode_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists scanned codes on the device (newest first, capped at [maxItems]).
class HistoryStore {
  static const String key = 'scan_history';
  static const int maxItems = 100;

  static Future<List<QRCode>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(key) ?? const <String>[];
    final items = <QRCode>[];
    for (final entry in raw) {
      try {
        items.add(QRCode.fromJson(jsonDecode(entry) as Map));
      } catch (_) {
        // Skip corrupt entries instead of failing the whole history.
      }
    }
    return items;
  }

  static Future<void> add(QRCode code) async {
    final items = await load();
    items.removeWhere((c) => c.qrString == code.qrString);
    items.insert(0, code);
    await _save(items.take(maxItems).toList());
  }

  static Future<void> remove(int id) async {
    final items = await load();
    items.removeWhere((c) => c.id == id);
    await _save(items);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<void> _save(List<QRCode> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, [
      for (final c in items) jsonEncode(c.toJson()),
    ]);
  }
}
