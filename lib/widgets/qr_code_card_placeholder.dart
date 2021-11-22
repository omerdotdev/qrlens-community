import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qrlens_community/widgets/outlined_btn_widget.dart';
import 'package:qrlens_community/config/strings.dart';

class QRCodePlaceholder extends StatelessWidget {
  const QRCodePlaceholder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 4.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(128)),
                child: Container(
                  decoration: BoxDecoration(
                      // color: generateMaterialColor(Palette.primary)[300],
                      // border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(128))),
                  width: 64,
                  height: 64,
                  child: Image(
                    image: AssetImage(
                      "assets/ic_launcher_round.png",
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${AppStrings["AppName"]}",
                style: TextStyle(
                  // color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppStrings["TAGLINE"],
                style: TextStyle(
                  // color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppStrings["EDITION"],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlineButtonWidget(
                      onPressed: null,
                      label: "Github",
                      icon: FontAwesomeIcons.github,
                      url: AppStrings['github_link']),
                  OutlineButtonWidget(
                      onPressed: null,
                      label: "Review",
                      icon: Icons.rate_review,
                      url: AppStrings['review']),
                  OutlineButtonWidget(
                      onPressed: null,
                      label: "Support",
                      icon: Icons.support_rounded,
                      url: AppStrings['support'])
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
