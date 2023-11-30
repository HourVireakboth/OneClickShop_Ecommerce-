import 'package:flutter/material.dart';

import '../../../../../misc/color.dart';

class CardPromotion extends StatelessWidget {
  final String? image;
  const CardPromotion({
        this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
        image:  DecorationImage(
            image: AssetImage(image!),fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(25),
        color: AppColor.icongreyColor,
      ),
      height: 215,
      width: 355,
      margin: const EdgeInsets.all(10),
    );
  }
}
