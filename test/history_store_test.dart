import 'package:flutter_test/flutter_test.dart';
import 'package:qrlens_community/data/history_store.dart';
import 'package:qrlens_community/data/models/qrcode_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('adds newest first and de-duplicates by content', () async {
    await HistoryStore.add(QRCode(1, 'a', 'qrCode'));
    await HistoryStore.add(QRCode(2, 'b', 'qrCode'));
    await HistoryStore.add(QRCode(3, 'a', 'qrCode'));
    final items = await HistoryStore.load();
    expect(items.map((c) => c.qrString), ['a', 'b']);
    expect(items.first.id, 3);
  });

  test('caps history size', () async {
    for (var i = 0; i < HistoryStore.maxItems + 5; i++) {
      await HistoryStore.add(QRCode(i, 'c$i', 'qrCode'));
    }
    expect((await HistoryStore.load()).length, HistoryStore.maxItems);
  });

  test('remove, clear and corrupt entries', () async {
    await HistoryStore.add(QRCode(1, 'a', 'qrCode'));
    await HistoryStore.add(QRCode(2, 'b', 'qrCode'));
    await HistoryStore.remove(1);
    expect((await HistoryStore.load()).single.qrString, 'b');
    await HistoryStore.clear();
    expect(await HistoryStore.load(), isEmpty);

    SharedPreferences.setMockInitialValues({
      HistoryStore.key: ['not json', '{"id":1,"qrString":"x","type":"t"}'],
    });
    expect((await HistoryStore.load()).single.qrString, 'x');
  });
}
