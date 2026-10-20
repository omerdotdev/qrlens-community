import 'package:flutter/material.dart';
import 'package:qrlens_community/widgets/body.dart';
import 'package:qrlens_community/config/strings.dart';
import 'package:qrlens_community/widgets/history_page.dart';

class QRHome extends StatefulWidget {
  const QRHome({super.key, this.title});
  final String? title;
  @override
  State<QRHome> createState() => _QRHomeState();
}

class _QRHomeState extends State<QRHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Body(),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                tooltip: 'Scan history',
                icon: Icon(Icons.history, color: Theme.of(context).cardColor),
                onPressed: () => Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const HistoryPage())),
              ),
              Builder(
                builder: (context) => IconButton(
                  tooltip: 'Open navigation menu',
                  icon: Icon(Icons.info, color: Theme.of(context).cardColor),
                  onPressed: () {
                    showAboutDialog(
                      context: context,
                      applicationIcon: const Image(
                        image: AssetImage('assets/ic_launcher_round.png'),
                        fit: BoxFit.scaleDown,
                        height: 64,
                        width: 64,
                      ),
                      applicationName: appStrings["AppName"],
                      applicationVersion: appStrings["EDITION"],
                      applicationLegalese: 'Omer Asif',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
