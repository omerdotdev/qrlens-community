import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrlens_community/widgets/outlined_btn_widget.dart';
import 'package:qrlens_community/widgets/qr_code_card_placeholder.dart';
import 'package:qrlens_community/bloc/qrbloc_bloc.dart';
import 'package:qrlens_community/utils/utils.dart';

class QRCodeCard extends StatefulWidget {
  const QRCodeCard({Key key}) : super(key: key);

  @override
  _QRCodeCardState createState() => _QRCodeCardState();
}

class _QRCodeCardState extends State<QRCodeCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QRBloc, QRState>(
      builder: (context, state) {
        if (state is QRInitial) {
          return QRCodePlaceholder();
        } else if (state is QRInstanceState) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: _buildQRCodeCard(state, context),
            ),
          );
        } else {
          return Text("Oops! Something went wrong!");
        }
      },
    );
  }

  Widget _buildQRCodeCard(QRInstanceState state, BuildContext context) {
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "QR Code",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(state.code.qrString.toString()),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                              borderRadius: BorderRadius.circular(12)),
                          label:
                              Text(state.code.type.toLowerCase().toString())),
                    ),
                  ],
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
                            Clipboard.setData(ClipboardData(
                                text: state.code.qrString.toString()));
                            Utils.showSnackBarWith(
                                context, "Copied", Icons.copy_rounded);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButtonWidget(
                        url: state.code.qrString,
                        onPressed: null,
                        label: "Open",
                        icon: Icons.open_in_browser_rounded,
                        snackBarErrMsg: "LOL: Link Not Found!",
                        snackBarErrorIcon: Icons.error_outline_rounded,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 0.0,
            right: 0.0,
            child: TextButton(
              style:
                  TextButton.styleFrom(primary: Theme.of(context).primaryColor),
              autofocus: false,
              onPressed: () {
                BlocProvider.of<QRBloc>(context).add(QRInit());
              },
              child: Icon(Icons.clear),
            ),
          ),
        ],
      ),
    );
  }
}
