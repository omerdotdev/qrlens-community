import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrlens_community/widgets/outlined_btn_widget.dart';
import 'package:qrlens_community/widgets/qr_code_card_placeholder.dart';
import 'package:qrlens_community/bloc/qrbloc_bloc.dart';
import 'package:qrlens_community/utils/link_check.dart';
import 'package:qrlens_community/utils/utils.dart';

class QRCodeCard extends StatefulWidget {
  const QRCodeCard({super.key});

  @override
  State<QRCodeCard> createState() => _QRCodeCardState();
}

class _QRCodeCardState extends State<QRCodeCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QRBloc, QRState>(
      builder: (context, state) {
        if (state is QRInitial) {
          return const QRCodePlaceholder();
        } else if (state is QRInstanceState) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: _buildQRCodeCard(state, context),
            ),
          );
        } else {
          return const Text("Oops! Something went wrong!");
        }
      },
    );
  }

  Future<void> _confirmAndOpen(
    BuildContext context,
    String code,
    List<String> warnings,
  ) async {
    final open = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning_amber_rounded),
        title: const Text("Open this link?"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(code),
            const SizedBox(height: 12),
            for (final w in warnings)
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text("• $w"),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Open anyway"),
          ),
        ],
      ),
    );
    if (open != true) return;
    final ok = await Utils.lauchURl(code);
    if (!ok && context.mounted) {
      Utils.showSnackBarWith(
        context,
        "LOL: Link Not Found!",
        Icons.error_outline_rounded,
      );
    }
  }

  Widget _buildQRCodeCard(QRInstanceState state, BuildContext context) {
    final uri = Utils.safeWebUri(state.code.qrString);
    final warnings = uri == null ? const <String>[] : LinkCheck.warnings(uri);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 4.0,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "QR Code",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(state.code.qrString.toString()),
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Type:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Chip(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        label: Text(state.code.type.toLowerCase().toString()),
                      ),
                    ),
                  ],
                ),
                if (warnings.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.warning_amber_rounded, size: 18),
                        SizedBox(width: 6),
                        Flexible(child: Text("Check this link before opening")),
                      ],
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButtonWidget(
                        url: "",
                        icon: Icons.copy_rounded,
                        label: "Copy",
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: state.code.qrString.toString()),
                          );
                          Utils.showSnackBarWith(
                            context,
                            "Copied",
                            Icons.copy_rounded,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButtonWidget(
                        url: state.code.qrString,
                        onPressed: warnings.isEmpty
                            ? null
                            : () => _confirmAndOpen(
                                context,
                                state.code.qrString,
                                warnings,
                              ),
                        label: "Open",
                        icon: Icons.open_in_browser_rounded,
                        snackBarErrMsg: "LOL: Link Not Found!",
                        snackBarErrorIcon: Icons.error_outline_rounded,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 0.0,
            right: 0.0,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
              ),
              autofocus: false,
              onPressed: () {
                BlocProvider.of<QRBloc>(context).add(QRInit());
              },
              child: const Icon(Icons.clear),
            ),
          ),
        ],
      ),
    );
  }
}
