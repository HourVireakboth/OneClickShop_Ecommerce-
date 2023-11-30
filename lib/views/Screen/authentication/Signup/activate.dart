import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneclickshop/misc/color.dart';
import 'package:oneclickshop/viewmodel/authverifysms/verifysms_bloc.dart';
import 'package:oneclickshop/views/Screen/Page/page.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivateScreen extends StatefulWidget {
  const ActivateScreen({super.key});

  @override
  State<ActivateScreen> createState() => _ActivateScreenState();
}

class _ActivateScreenState extends State<ActivateScreen> {
  GlobalKey<State> dialogKey = GlobalKey<State>();
  var activatecode = TextEditingController();
  int secondsRemaining = 30;
  bool enableResend = false;
  Timer? timer;
  bool checkcode = false;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  FocusNode pincode = FocusNode();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocListener<VerifysmsBloc, VerifysmsState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is VerifysmsInvalid) {
              Future.delayed(const Duration(seconds: 2),
                  () => FocusScope.of(context).requestFocus(pincode));
              Future.delayed(const Duration(seconds: 2), () => checkcode = true);
              Future.delayed(
                  const Duration(seconds: 2), () => activatecode.clear());
              Future.delayed(const Duration(seconds: 2),
                  () => Navigator.of(context, rootNavigator: true).pop());
            }
            if (state is VerifysmsCompleted) {
              print('Token = ${state.responseModel?.token}');
              setLoginTrue(
                  activatecode.text.toString(), state.responseModel?.token);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Future.delayed(
                    const Duration(seconds: 2),
                    () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => PageMain()),
                        (context) => false));
              });
            }
          },
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/Image/Activebackground.png"),
                    fit: BoxFit.contain)),
            height: double.maxFinite,
            width: double.infinity,
            child: Stack(children: [
              Positioned(
                top: size.height * 0.075,
                left: size.width * 0.095,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Activate you",
                      style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "account",
                      style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Text(
                      "Enter the -digit code sent to your phone number by SMS. ",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColor.textgreyColor),
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    Pinput(
                      enableSuggestions: true,
                      // validator: (s) {
                      //   if (checkcode) {
                      //     return "Incorrect code";
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      focusNode: pincode,
    
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      autofocus: true,
                      controller: activatecode,
                      onCompleted: (value) {
                        print("done");
                        print(value);
                        BlocProvider.of<VerifysmsBloc>(context).add(VerifySMSUser(
                            verifycode: activatecode.text.toString()));
                        // showDialogLogin(context, dialogKey);
                        showDialogLogin(context);
                      },
                      onChanged: (value) {
                        print(value);
                      },
    
                      length: 6,
                      showCursor: true,
                      defaultPinTheme: PinTheme(
                          width: 46,
                          height: 56,
                          textStyle: const TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(30, 60, 87, 1),
                              fontWeight: FontWeight.w600),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColor.textBlackColor, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                    checkcode == true
                        ? const Text(
                            'Incorrent Pin',
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          )
                        : const Text(""),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    const Text(
                      "Didn't receive it?",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    enableResend == false
                        ? Text(
                            "Get new code by WhatsApp in 00:$secondsRemaining  ",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColor.textgreyColor),
                          )
                        : RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      _resendCode();
                                    },
                                  text: 'Get new code ',
                                  style: TextStyle(
                                      color: AppColor.textBlueWhite,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: ' or ',
                                  style: TextStyle(
                                      color: AppColor.textgreyColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      _resendCode();
                                    },
                                  text: ' send by WhatApp',
                                  style: TextStyle(
                                      color: AppColor.textBlueWhite,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void _resendCode() {
    //other code here
    setState(() {
      secondsRemaining = 30;
      enableResend = false;
    });
  }

  @override
  dispose() {
    timer!.cancel();
    super.dispose();
  }
}

void pop(context) {
  Navigator.of(context, rootNavigator: true).pop();
}

void showDialogLogin(BuildContext context) {
  showDialog(
    barrierColor: Colors.transparent,
    barrierDismissible: true,
    context: context,
    builder: (context) => Center(
      child: Container(
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: CupertinoActivityIndicator(),
        ),
      ),
    ),
  );
}

void setLoginTrue(activecode, token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("islogin", true);
  print("islogin = ${prefs.getBool("islogin")}");
  prefs.setString("istoken", token.toString());
  print("isToken = ${prefs.getString("istoken")}");
  prefs.setString("otpsms", activecode.toString());
  print("otpsms = ${prefs.getString("otpsms")}");
}


// Future showDialogLogin(BuildContext context, dialogKey) async {
//   return showDialog(
//       barrierDismissible: true,
//       barrierColor: Colors.transparent,
//       context: context,
//       builder: (BuildContext context) {
//         return Padding(
//             padding: EdgeInsets.only(left: 50.0, right: 50.0),
//             child: //AlertDialog or any other Dialog you can use
//                 Dialog(
//                     elevation: 0.0,
//                     backgroundColor: Colors.transparent,
//                     child: Container(
//                       width: 10.0,
//                       height: 50.0,
//                       color: Colors.red,
//                     )));
//       });
//}
