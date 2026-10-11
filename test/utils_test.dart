import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qrlens_community/utils/utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Utils.scanFeedback triggers a haptic impact', () async {
    final calls = <String?>[];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (call) async {
          if (call.method == 'HapticFeedback.vibrate') {
            calls.add(call.arguments as String?);
          }
          return null;
        });
    await Utils.scanFeedback();
    expect(calls, ['HapticFeedbackType.mediumImpact']);
  });

  group('Utils.safeWebUri', () {
    test('accepts http and https links', () {
      expect(Utils.safeWebUri('https://example.com/a?b=1'), isNotNull);
      expect(Utils.safeWebUri('http://example.com'), isNotNull);
      expect(Utils.safeWebUri('  https://example.com  '), isNotNull);
    });

    test('rejects other schemes scanned from untrusted QR codes', () {
      for (final code in [
        'tel:+123456789',
        'sms:+123456789?body=hi',
        'intent://scan/#Intent;scheme=zxing;end',
        'file:///etc/passwd',
        'javascript:alert(1)',
        'market://details?id=x',
      ]) {
        expect(Utils.safeWebUri(code), isNull, reason: code);
      }
    });

    test('rejects plain text and malformed input', () {
      expect(Utils.safeWebUri('hello world'), isNull);
      expect(Utils.safeWebUri(''), isNull);
      expect(Utils.safeWebUri('https://'), isNull);
    });
  });
}
