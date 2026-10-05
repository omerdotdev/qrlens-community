import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrlens_community/data/models/qrcode_model.dart';
import 'package:qrlens_community/widgets/qr_code_card.dart';
import 'package:qrlens_community/bloc/qrbloc_bloc.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with WidgetsBindingObserver {
  late final MobileScannerController _controller;
  bool _flashOn = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = MobileScannerController();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQRCamW(),
            const QRCodeCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildQRCamW() {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: (MediaQuery.of(context).size.height * 0.50).roundToDouble(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: MobileScanner(
                  controller: _controller,
                  onDetect: (BarcodeCapture capture) {
                    final barcodes = capture.barcodes;
                    for (final barcode in barcodes) {
                      final code = barcode.rawValue;
                      if (code != null) {
                        BlocProvider.of<QRBloc>(context).add(QRLoad(QRCode(
                          Random.secure().nextInt(100),
                          code,
                          barcode.format.name,
                        )));
                      }
                    }
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: IconButton(
                  onPressed: _toggleFlash,
                  color: Colors.white,
                  iconSize: 36,
                  icon: Icon(_flashOn ? Icons.flash_off : Icons.flash_on),
                  alignment: Alignment.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleFlash() async {
    await _controller.toggleTorch();
    setState(() {
      _flashOn = !_flashOn;
    });
  }
}
