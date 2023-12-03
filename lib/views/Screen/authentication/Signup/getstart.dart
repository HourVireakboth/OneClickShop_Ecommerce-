// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oneclickshop/helper/fromvalidate.dart';
import 'package:oneclickshop/views/Screen/authentication/Signup/signup.dart';

import '../../../../misc/color.dart';
import '../No_Login/nologin_signup.dart';
import '../No_Login/widget/button.dart';

class GetStart extends StatefulWidget {
  GetStart({this.areadyexist, this.username, this.email, super.key});
  String? username;
  String? email;
  bool? areadyexist;
  @override
  State<GetStart> createState() => _GetStartState();
}

class _GetStartState extends State<GetStart> {
  @override
  void initState() {
    if (widget.areadyexist!) {
      contactName.text = widget.username.toString();
      email.text = widget.email.toString();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        globalkey.currentState!.validate();
      });
    }
    super.initState();
  }

  var globalkey = GlobalKey<FormState>();
  var globalkey1 = GlobalKey<FormState>();
  var contactName = TextEditingController();
  var email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage("assets/Image/GetStartedBackground.png"),
                      fit: BoxFit.contain)),
              height: double.maxFinite,
              width: double.infinity,
              child: Stack(children: [
                Positioned(
                    top: constraints.maxHeight * 0.075,
                    left: constraints.maxWidth * 0.08,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) {
                              return const NoLoginSignU();
                            }), (route) => false);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new_sharp,
                            size: 35,
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.16,
                        ),
                        const Text(
                          "Get Started",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                Positioned(
                  top: constraints.maxHeight * 0.15,
                  child: Container(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Name",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.02,
                        ),
                        Form(
                          key: globalkey,
                          child: TextFormField(
                            autofocus: true,
                            validator: (contactname) {
                              if (widget.areadyexist!) {
                                return 'Your name have already exist!';
                              }
                              if (contactname!.isEmpty) {
                                return 'Please enter your Name';
                              } else {
                                if (extString(contactname).isValidName) {
                                  return null;
                                } else {
                                  return 'Invaild Name';
                                }
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                              widget.areadyexist = false;
                                
                              });
                              if (globalkey.currentState!.validate()) {
                                globalkey.currentState!.save();
                              }
                            },
                            onFieldSubmitted: (userInput) {
                              if (globalkey.currentState!.validate()) {
                                globalkey.currentState!.save();
                              }
                            },
                            controller: contactName,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColor.backgroundWhite,
                              hintText: "What should the people call you",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: AppColor.textgreyColor),
                                  borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: AppColor.textgreyColor),
                                  borderRadius: BorderRadius.circular(30)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: AppColor.textgreyColor),
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.03,
                        ),
                        const Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.02,
                        ),
                        Form(
                          key: globalkey1,
                          child: TextFormField(
                            validator: (contactname) {
                              if (contactname!.isEmpty) {
                                return 'Please enter your Email';
                              } else {
                                if (extString(contactname).isValidEmail) {
                                  return null;
                                } else {
                                  return 'Invaild email format';
                                }
                              }
                            },
                            onChanged: (value) {
                              if (globalkey1.currentState!.validate()) {
                                globalkey1.currentState!.save();
                              }
                            },
                            onFieldSubmitted: (userInput) {
                              if (globalkey1.currentState!.validate()) {
                                globalkey1.currentState!.save();
                              }
                            },
                            controller: email,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColor.backgroundWhite,
                              hintText: "Email",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: AppColor.textgreyColor),
                                  borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: AppColor.textgreyColor),
                                  borderRadius: BorderRadius.circular(30)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: AppColor.textgreyColor),
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: constraints.maxHeight * 0.5,
                  left: constraints.maxWidth * 0.1,
                  right: constraints.maxWidth * 0.1,
                  child: GestureDetector(
                    onTap: () {},
                    child: GestureDetector(
                      onTap: () {
                        if (contactName.text.isValidName &&
                            email.text.isValidEmail) {
                          print("Correct");
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return SignupScreen();
                          }), (route) => false);
                        } else {
                          //POP
                          print("not Correct");
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          if (contactName.text.isValidName &&
                              email.text.isValidEmail) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => SignupScreen(
                                          isRegister: true,
                                          email: email.text,
                                          username: contactName.text,
                                        )),
                                (route) => false);
                          } else {}
                        },
                        child: Button(
                          sizeHeight: 60,
                          sizeWidth: 355,
                          text: "Next",
                          fontWeight: FontWeight.bold,
                          textSize: 25,
                          colorText: AppColor.textBlackColor,
                          colorBackground: AppColor.backgroudButtonColor2,
                          raduis: 30,
                        ),
                      ),
                    ),
                  ),
                )
              ]),
            );
          },
        ),
      ),
    );
  }
}
