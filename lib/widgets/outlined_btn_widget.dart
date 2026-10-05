import 'package:flutter/material.dart';
import 'package:qrlens_community/utils/utils.dart';

class OutlineButtonWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final String url;
  final bool showSnackbar;
  final String? snackBarMessage;
  final String? snackBarErrMsg;
  final IconData? snackBarMessageIcon;
  final IconData? snackBarErrorIcon;
  final VoidCallback? onPressed;

  const OutlineButtonWidget({
    Key? key,
    required this.label,
    required this.icon,
    required this.url,
    this.showSnackbar = true,
    this.snackBarMessage,
    this.snackBarErrMsg,
    this.snackBarMessageIcon,
    this.snackBarErrorIcon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed:
          onPressed ??
          () async {
            if (showSnackbar) {
              final yes = await Utils.lauchURl(url);
              if (!yes && context.mounted) {
                Utils.showSnackBarWith(
                  context,
                  snackBarErrMsg ?? 'Error opening link',
                  snackBarErrorIcon ?? Icons.error_outline_rounded,
                );
              }
            }
          },
      label: Text(label),
      icon: Icon(icon),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        foregroundColor: Theme.of(context).primaryColor,
        side: BorderSide(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
