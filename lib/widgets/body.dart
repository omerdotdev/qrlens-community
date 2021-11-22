import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrlens_community/widgets/qr_code_card.dart';
import 'package:qrlens_community/bloc/qrbloc_bloc.dart';
import 'package:qrlens_community/data/models/m_qrcode.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with WidgetsBindingObserver {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController _controller;
  bool _flashOn = false;
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller.stopCamera();
      _controller.flipCamera();
      _controller.stopCamera();
      _controller.flipCamera();
      _controller.resumeCamera();
    } else if (Platform.isIOS) {
      // controller.pauseCamera();
      _controller.resumeCamera();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.stopCamera();
    _controller?.dispose();
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
            qRCamW(),
            QRCodeCard(),
          ],
        ),
      ),
    );
  }

  Widget qRCamW() {
    return Center(
      child: Container(
          width: double.infinity,
          height: (MediaQuery.of(context).size.height * 0.50).roundToDouble(),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.0),
                  child: QRView(
                    cameraFacing: CameraFacing.back,
                    key: qrKey,
                    onQRViewCreated: (p0) {
                      _controller = p0;
                      _controller.scannedDataStream.listen((event) {
                        BlocProvider.of<QRBloc>(context).add(QRLoad(QRCode(
                            Random.secure().nextInt(100),
                            event.code,
                            event.format.formatName,
                            false)));
                      });
                    },
                    overlay: QrScannerOverlayShape(
                      borderColor: Theme.of(context).primaryColor,
                      borderRadius: 8,
                      borderLength: 36,
                      cutOutSize: 256,
                      cutOutBottomOffset: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: IconButton(
                    onPressed: () {
                      debugPrint(
                          "Controller is dead?: " + _controller.toString());
                      _controller.toggleFlash();
                      setState(() {
                        _flashOn = !_flashOn;
                      });
                    },
                    color: Colors.white,
                    iconSize: 36,
                    icon: Icon(_flashOn ? Icons.flash_off : Icons.flash_on),
                    alignment: Alignment.center,
                  ),
                ),
                bottom: 0.0,
                left: 0.0,
              )
            ],
          )),
    );
  }
}
