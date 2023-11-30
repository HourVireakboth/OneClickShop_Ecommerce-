import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  double? sizeWidth;
  double? sizeHeight;
  double? raduis;
  String? text;
  double? textSize;
  FontWeight? fontWeight;
  Color? colorText;
  Color? colorBackground;

  Button({
    this.sizeWidth,
    this.sizeHeight,
    this.raduis,
    this.text,
    this.textSize,
    this.fontWeight,
    this.colorText,
    this.colorBackground,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeWidth,
      height: sizeHeight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(raduis!)),
          color: colorBackground),
      child: Center(
          child: Text(
        text!,
        style: TextStyle(
            color: colorText, fontSize: textSize, fontWeight: fontWeight),
      )),
    );
  }
}
