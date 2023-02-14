import 'package:flutter/material.dart';
import 'package:wallpaper_app/extra/constants.dart';

class LogoWidget extends StatelessWidget {
  LogoWidget({Key? key, this.iconSize, this.textSize}) : super(key: key);
  double? textSize;
  double? iconSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "./assets/logo.png",
          width: iconSize ?? MediaQuery.of(context).size.width * 0.16,
          fit: BoxFit.contain,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Text(
          "Wallpaper App",
          style: TextStyle(
              color: black,
              fontWeight: FontWeight.w600,
              fontFamily: handlee,
              fontSize: textSize ?? 32),
        )
      ],
    );
  }
}
