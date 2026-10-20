import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrlens_community/data/models/qrcode_model.dart';
import 'package:qrlens_community/widgets/qr_code_card.dart';
import 'package:qrlens_community/widgets/scan_frame.dart';
import 'package:qrlens_community/bloc/qrbloc_bloc.dart';
import 'package:qrlens_community/data/history_store.dart';
import 'package:qrlens_community/utils/utils.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with WidgetsBindingObserver {
  late final MobileScannerController _controller;
  bool _flashOn = false;
  String? _lastCode;

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
          children: [_buildQRCamW(), const QRCodeCard()],
        ),
      ),
    );
  }

  Widget _buildQRCamW() {
    return BlocListener<QRBloc, QRState>(
      // Allow re-scanning the same code after the result card is dismissed.
      listenWhen: (previous, current) => current is QRInitial,
      listener: (context, state) => _lastCode = null,
      child: Center(
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
                    onDetect: _handleCapture,
                  ),
                ),
              ),
              const ScanFrame(),
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
              if (!kIsWeb)
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: IconButton(
                      tooltip: 'Scan from image',
                      onPressed: _scanFromImage,
                      color: Colors.white,
                      iconSize: 36,
                      icon: const Icon(Icons.image),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleCapture(BarcodeCapture capture) {
    for (final barcode in capture.barcodes) {
      final code = barcode.rawValue;
      if (code != null && code != _lastCode) {
        // onDetect fires for every camera frame; only emit
        // when the scanned value actually changes.
        _lastCode = code;
        Utils.scanFeedback();
        final scanned = QRCode(
          DateTime.now().microsecondsSinceEpoch,
          code,
          barcode.format.name,
        );
        HistoryStore.add(scanned);
        BlocProvider.of<QRBloc>(context).add(QRLoad(scanned));
      }
    }
  }

  Future<void> _scanFromImage() async {
    final messenger = ScaffoldMessenger.of(context);
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final capture = await _controller.analyzeImage(image.path);
    if (!mounted) return;
    if (capture == null || capture.barcodes.isEmpty) {
      messenger.showSnackBar(
        const SnackBar(content: Text('No QR code found in the image')),
      );
      return;
    }
    _handleCapture(capture);
  }

  Future<void> _toggleFlash() async {
    await _controller.toggleTorch();
    setState(() {
      _flashOn = !_flashOn;
    });
  }
}
