import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qrlens_community/widgets/scan_frame.dart';

void main() {
  testWidgets('ScanFrame renders a square frame without blocking taps', (
    tester,
  ) async {
    var taps = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Stack(
          children: [
            Positioned.fill(child: GestureDetector(onTap: () => taps++)),
            const ScanFrame(),
          ],
        ),
      ),
    );

    final size = tester.getSize(find.byType(CustomPaint).last);
    expect(size.width, size.height);
    expect(size.width, greaterThan(0));

    await tester.tap(find.byType(ScanFrame));
    expect(taps, 1);
  });
}
