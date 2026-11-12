import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qrlens_community/bloc/qrbloc_bloc.dart';
import 'package:qrlens_community/data/models/qrcode_model.dart';
import 'package:qrlens_community/utils/link_check.dart';
import 'package:qrlens_community/widgets/qr_code_card.dart';

List<String> check(String url) => LinkCheck.warnings(Uri.parse(url));

void main() {
  group('LinkCheck.warnings', () {
    test('ordinary https links are not flagged', () {
      expect(check('https://example.com/path?q=1'), isEmpty);
      expect(check('https://www.github.com'), isEmpty);
      expect(check('https://example.com:443/'), isEmpty);
    });

    test('flags unencrypted http', () {
      expect(check('http://example.com'), hasLength(1));
    });

    test('flags user info before @', () {
      expect(check('https://paypal.com@evil.example'), hasLength(1));
    });

    test('flags raw IP addresses', () {
      expect(check('https://192.168.0.1/login'), hasLength(1));
      expect(check('https://[::1]/'), hasLength(1));
    });

    test('flags punycode and non-ASCII domains', () {
      expect(check('https://xn--pple-43d.com'), hasLength(1));
      expect(check('https://аpple.com'), hasLength(1));
    });

    test('flags URL shorteners', () {
      expect(check('https://bit.ly/abc'), hasLength(1));
      expect(check('https://www.tinyurl.com/abc'), hasLength(1));
      expect(check('https://notbit.ly/abc'), isEmpty);
    });

    test('flags unusual ports', () {
      expect(check('https://example.com:8443/'), hasLength(1));
    });

    test('reasons accumulate', () {
      expect(check('http://user@10.0.0.1:8080/'), hasLength(4));
    });
  });

  group('QRCodeCard', () {
    Future<void> pumpCard(WidgetTester tester, String code) async {
      final bloc = QRBloc()..add(QRLoad(QRCode(1, code, 'url')));
      addTearDown(bloc.close);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(value: bloc, child: const QRCodeCard()),
          ),
        ),
      );
      await tester.pump();
    }

    testWidgets('safe link shows no warning', (tester) async {
      await pumpCard(tester, 'https://example.com');
      expect(find.text('Check this link before opening'), findsNothing);
    });

    testWidgets('risky link shows warning and asks before opening', (
      tester,
    ) async {
      await pumpCard(tester, 'http://bit.ly/x');
      expect(find.text('Check this link before opening'), findsOneWidget);

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('Open this link?'), findsOneWidget);
      expect(find.textContaining('not encrypted'), findsOneWidget);
      expect(find.textContaining('shortened'), findsOneWidget);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.text('Open this link?'), findsNothing);
    });
  });
}
