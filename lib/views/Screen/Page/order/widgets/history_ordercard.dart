import 'package:flutter/material.dart';

import '../../../../../misc/color.dart';

Widget historyOrderCard(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Container(
    padding: const EdgeInsets.all(20),
    margin:const EdgeInsets.only(bottom: 30),
    height: 90,
    width: 355,
    decoration: BoxDecoration(
      color: AppColor.backgroundWhite,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1), //color of shadow
          spreadRadius: 5, //spread radius
          blurRadius: 7, // blur radius
          offset: const Offset(2, 2), // changes position of shadow
          //first paramerter of offset is left-right
          //second parameter is top to down
        )
      ],
    ),
    child: Row(
      children: [
        Column(
          children: [
            const Text(
              "Order No. #78 789",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "\$1889 - 10 October 2023",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textgreyColor),
            ),
          ],
        ),
        SizedBox(
          width: size.width * 0.03,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/Image/iphone14promax.png",
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            Image.asset(
              "assets/Image/nike.png",
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Container(
              height: 20,
              width: 20,
              decoration: ShapeDecoration(
                  shape: const CircleBorder(), color: Colors.grey[200]),
              child: const Text("+2"),
            )
          ],
        )
      ],
    ),
  );
}
