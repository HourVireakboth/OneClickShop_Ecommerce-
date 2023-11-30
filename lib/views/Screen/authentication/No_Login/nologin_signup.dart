import "package:flutter/material.dart";
import "package:oneclickshop/misc/color.dart";
import 'package:oneclickshop/views/Screen/authentication/Login/login.dart';
import "package:oneclickshop/views/Screen/authentication/Signup/getstart.dart";

import "widget/button.dart";
import "widget/card_promotion.dart";

class NoLoginSignU extends StatefulWidget {
  const NoLoginSignU({super.key});

  @override
  State<NoLoginSignU> createState() => _NoLoginSignUpState();
}

class _NoLoginSignUpState extends State<NoLoginSignU> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _displayAlertSignUpLogin(context);
              });
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.all(0),
                    child: Stack(clipBehavior: Clip.none, children: [
                      const Image(
                        image: AssetImage("assets/Image/styletop.png"),
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        left: 30,
                        top: 55,
                        child: Row(
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Here for the first time?",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Sign up to do more with OneClickShop !",
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Icon(
                                      Icons.arrow_circle_right_sharp,
                                      size: 18,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(20, 0, 0, 50),
                              height: 115,
                              width: 115,
                              child: const Image(
                                  image: AssetImage(
                                      "assets/Image/SignUpFirst.png")),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        left: 40,
                        right: 40,
                        top: 180,
                        child: Container(
                          height: 50,
                          width: 355,
                          decoration: BoxDecoration(
                              color: AppColor.backgroundWhite,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  width: 1.0, color: AppColor.bordergreyColor)),
                          child: Row(children: [
                            const SizedBox(
                              width: 20,
                            ),
                            const Image(
                              image: AssetImage("assets/Image/iconsearch.png"),
                              width: 25,
                              height: 25,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Search",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.textgreyColor),
                            )
                          ]),
                        ),
                      ),
                    ]),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                    height: size.height * 0.28,
                    child: PageView.builder(
                      controller:
                          PageController(initialPage: 1, viewportFraction: 0.8),
                      itemCount: lsPromotion.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CardPromotion(
                          image: lsPromotion[index],
                        );
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 35, 0, 25),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: AppColor.textBlackColor),
                      )),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    height: size.height * 0.24,
                    child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: lsCategories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 28,
                                mainAxisSpacing: 2,
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(0),
                            height: 85,
                            width: 85,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: AppColor.backgroudButtonColor,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Image(
                                    image: AssetImage(lsCategories[index]),
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  lsCategoriesName[index],
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.only(left: 30, right: 30),
              height: size.height * 0.11,
              width: size.width * 1.0,
              decoration: BoxDecoration(
                  color: AppColor.backgroundWhite,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                      // changes position of shadow
                    ),
                  ]),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return GetStart(areadyexist: false,);
                        }), (route) => false);
                      },
                      child: Button(
                        sizeHeight: 60,
                        sizeWidth: 170,
                        textSize: 20,
                        raduis: 30,
                        text: "SignUp",
                        fontWeight: FontWeight.bold,
                        colorText: AppColor.textBlackColor,
                        colorBackground: AppColor.backgroudButtonColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return const LoginScreen();
                        }), (route) => false);
                      },
                      child: Button(
                        sizeHeight: 60,
                        sizeWidth: 170,
                        textSize: 20,
                        raduis: 30,
                        text: "Login",
                        fontWeight: FontWeight.bold,
                        colorText: AppColor.backgroundWhite,
                        colorBackground: AppColor.backgroudButtonColor2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Future _displayAlertSignUpLogin(BuildContext context) {
  return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
              color: AppColor.backgroundWhite,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 1.0,
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Let's get you in !",
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textBlackColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "in just a minute, you can access all our offers,",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textgreyColor),
              ),
              Text(
                "services and more.",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textgreyColor),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Expanded(
                    child:GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return  GetStart(areadyexist: false,);
                        }), (route) => false);
                      },
                      child: Button(
                        sizeHeight: 60,
                        sizeWidth: 170,
                        textSize: 20,
                        raduis: 30,
                        text: "SignUp",
                        fontWeight: FontWeight.bold,
                        colorText: AppColor.textBlackColor,
                        colorBackground: AppColor.backgroudButtonColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return const LoginScreen();
                        }), (route) => false);
                      },
                      child: Button(
                        sizeHeight: 60,
                        sizeWidth: 170,
                        textSize: 20,
                        raduis: 30,
                        text: "Login",
                        fontWeight: FontWeight.bold,
                        colorText: AppColor.backgroundWhite,
                        colorBackground: AppColor.backgroudButtonColor2,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        );
      });
}

List<String> lsPromotion = [
  "assets/Image/promotion_banner3.png",
  "assets/Image/promotion_banner1.png",
  "assets/Image/promotion_banner2.png",
  "assets/Image/promotion_banner4.png",
  "assets/Image/promotion_banner5.png",
  "assets/Image/promotion_banner6.png",
  "assets/Image/promotion_banner7.png",
  "assets/Image/promotion_banner8.png",
  "assets/Image/promotion_banner9.png",
  "assets/Image/promotion_banner10.png",
];

List<String> lsCategories = [
  "assets/Image/iconbook.png",
  "assets/Image/shoe.png",
  "assets/Image/Computer.png",
  "assets/Image/watch.png",
  "assets/Image/Phone.png",
  "assets/Image/Clothes.png",
  "assets/Image/Electronics.png",
  "assets/Image/Cosmetics.png"
];
List<String> lsCategoriesName = [
  "Books",
  "Shoes",
  "Laptops",
  "Watches",
  "Phones",
  "Clothes",
  "Electronics",
  "Accessories",
];
