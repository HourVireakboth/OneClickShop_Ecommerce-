import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oneclickshop/misc/color.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({super.key});

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  bool _switchValue = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backgroundWhite,
      body: Stack(children: [
        Positioned(
          top: -5,
          left: -10,
          child: Image.asset(
            "assets/Image/styletopleft.png",
            width: 80,
            height: 80,
          ),
        ),
        Positioned(
          top: -50,
          right: 0,
          child: Image.asset(
            "assets/Image/styletopright.png",
            width: 120,
            height: 170,
          ),
        ),
          Positioned(
          bottom: -40,
          left: 0,
          child: Image.asset(
            "assets/Image/StyleBottom.png",
            width: 290,
            height: 260,
          ),
        ),
         Positioned(
          bottom: size.height * 0.2,
          right: size.width * 0.01,
          child: Image.asset(
            "assets/Image/circlestyle.png",
            width: 40,
            height: 40,
          ),
        ),
        Positioned(
          bottom: size.height * 0.3,
          left: size.width * 0.25,
          child: Image.asset(
            "assets/Image/circlestyle.png",
            width: 20,
            height: 20,
          ),
        ),
        Positioned(
          bottom: size.height * 0.4,
          right: size.width * 0.2,
          child: Image.asset(
            "assets/Image/circlestyle.png",
            width: 40,
            height: 40,
          ),
        ),
        Positioned(
          top: size.height * 0.43,
          right: size.width * 0.08,
          child: Image.asset(
            "assets/Image/circlestyle.png",
            width: 50,
            height: 50,
          ),
        ),
        Positioned(
          top: size.height * 0.31,
          right: size.width * 0.08,
          child: Image.asset(
            "assets/Image/circlestyle.png",
            width: 20,
            height: 20,
          ),
        ),

        Positioned(
          top: size.height * 0.07,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.05),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back_ios_new_sharp,
                      size: 28,
                    )),
              ),
              Padding(
                  padding: EdgeInsets.only(left: size.width * 0.1),
                  child: const Text(
                    "Account Setting",
                    style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
        Positioned(
          top: size.height * 0.17,
          child: Container(
            padding: const EdgeInsets.only(left: 40, right: 40),
            height: size.height * 1.0,
            width: size.width * 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Notifications",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    CupertinoSwitch(
                      value: _switchValue,
                      onChanged: (value) {
                        setState(() {
                          _switchValue = value;
                        });
                      },
                    ),
                  ],
                ),
               SizedBox(height: size.height * 0.05,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Language Setting",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Text(
                          "EN",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.textBlueWhite),
                        )),
                  ],
                ),
                 SizedBox(height: size.height * 0.05,),
                const Text(
                  "Help",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                 SizedBox(height: size.height * 0.05,),
                const Text(
                  "Terms and Conditions",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                 SizedBox(height: size.height * 0.05,),
                const Text(
                  "Privacy & Policy",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
