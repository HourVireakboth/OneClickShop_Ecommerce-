import 'package:flutter/material.dart';

import '../../../../../misc/color.dart';


Widget Buttonlogin(BoxConstraints constraints , String icon ,String text) {
    return Container(
      width: constraints.maxWidth * 0.80,
      height: constraints.maxHeight * 0.05,
      decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: AppColor.bordergreyColor),
          borderRadius: BorderRadius.circular(30),
          color: AppColor.backgroundWhite),
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 30),
              child: Image(
                image: AssetImage(icon),
                fit: BoxFit.contain,
                width: constraints.maxWidth * 0.06,
                height: constraints.maxHeight * 0.06,
              )),
          Text(
            text,
            style: TextStyle(
                fontSize: 15,
                color: AppColor.textgreyColor,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
}