import 'package:flutter_test/flutter_test.dart';
import 'package:qrlens_community/bloc/qrbloc_bloc.dart';
import 'package:qrlens_community/data/models/qrcode_model.dart';

void main() {
  test('QRBloc emits the scanned code and resets on QRInit', () async {
    final bloc = QRBloc();
    final code = QRCode(1, 'https://example.com', 'qrCode');

    expect(bloc.state, isA<QRInitial>());

    bloc.add(QRLoad(code));
    await Future<void>.delayed(Duration.zero);
    expect(bloc.state, isA<QRInstanceState>());
    expect((bloc.state as QRInstanceState).code.qrString, code.qrString);

    bloc.add(QRInit());
    await Future<void>.delayed(Duration.zero);
    expect(bloc.state, isA<QRInitial>());

    await bloc.close();
  });

  test('QRCode.copyWith overrides only the given fields', () {
    final code = QRCode(1, 'a', 'qrCode').copyWith(qrstring: 'b');
    expect(code.id, 1);
    expect(code.qrString, 'b');
    expect(code.type, 'qrCode');
  });
}
