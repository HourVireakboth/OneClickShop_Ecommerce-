import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:oneclickshop/misc/color.dart';
import 'package:oneclickshop/model/Token/token.dart';
import 'package:oneclickshop/views/Screen/Page/cart/cartscreen.dart';
import 'package:oneclickshop/views/Screen/Page/home/homescreen.dart';
import 'package:oneclickshop/views/Screen/Page/search/searchscreen.dart';
import 'package:oneclickshop/views/Screen/Page/user/userscreen.dart';

class PageMain extends StatefulWidget {
  PageMain({super.key});
  @override
  State<PageMain> createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  TokenModel? tokenModel;

  List<Widget> screen = [
    HomeScreen(),
    SearchScreen(
      search: false,
    ),
    const CartScreen(),
    const UserScreen(),
  ];
  int index = 0;

  final item = [
    ImageIcon(
      const AssetImage("assets/Image/homeicon.png"),
      color: AppColor.textBlackColor,
      size: 20,
    ),
    ImageIcon(
      const AssetImage("assets/Image/searchicon.png"),
      color: AppColor.textBlackColor,
      size: 20,
    ),
    ImageIcon(
      const AssetImage("assets/Image/maketicon.png"),
      color: AppColor.textBlackColor,
      size: 20,
    ),
    ImageIcon(
      const AssetImage("assets/Image/profileicon.png"),
      color: AppColor.textBlackColor,
      size: 20,
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[index],
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (index) {
          setState(() {
            this.index = index;
          });
        },
        color: AppColor.backgroudButtonColor,
        animationCurve: Curves.easeIn,
        backgroundColor: AppColor.textBlackColor,
        items: item,
        index: index,
        buttonBackgroundColor: AppColor.backgroudButtonColor2,
      ),
    );
  }
}
