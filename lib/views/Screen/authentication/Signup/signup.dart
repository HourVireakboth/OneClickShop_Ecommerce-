// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:oneclickshop/misc/color.dart';
import 'package:oneclickshop/viewmodel/authlogin/login_bloc.dart';
import 'package:oneclickshop/viewmodel/authregister/authregister_bloc.dart';
import 'package:oneclickshop/views/Screen/authentication/No_Login/nologin_signup.dart';
import 'package:oneclickshop/views/Screen/authentication/No_Login/widget/button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneclickshop/views/Screen/authentication/Signup/activate.dart';

import 'getstart.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key, this.isRegister, this.username, this.email});
  bool? isRegister;
  String? username;
  String? email;
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController phoneNumber = TextEditingController();

  String initialCountry = 'KH';

  PhoneNumber number = PhoneNumber(isoCode: 'KH');
  String? phnumber;
  bool? isCheckLogin = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: MultiBlocListener(
            listeners: [
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginLoading) {
                    // return const Center(
                    //   child: CircularProgressIndicator(),
                    // );
                  }
                  if (state is LoginError) {
                    // return const Center(
                    //   child: Text("Error"),
                    // );
                  }

                  if (state is LoginUnAuthorize) {
                    Future.delayed(const Duration(seconds: 2), () {
                      setState(() {
                        isCheckLogin = true;
                      });
                      pop(context);
                    });
                  }

                  if (state is LoginCompleted) {
                    pop(context);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ActivateScreen()),
                          (context) => false);
                    });
                  }
                },
              ),
              BlocListener<AuthregisterBloc, AuthregisterState>(
                  listener: (context, state) {
                if (state is RegisterComplete) {
                  print("completed");
                   BlocProvider.of<LoginBloc>(context)
                       .add(LoginUser(phonenumber: phnumber.toString()));
                }

                if (state is RegisterUnAuthorize) {
                  //bool checked = true;
                  String phoneNumber =state.registertaken!.phoneNumber!.isEmpty ? "" : state.registertaken!.phoneNumber![0];

                  String name = state.registertaken!.username!.isEmpty ? "" : state.registertaken!.username![0];
                  if (phoneNumber.toString().contains(
                      'user with this phone number already exists.')) {
                    print('phone number');
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ActivateScreen()),
                    //     (route) => false);
                    BlocProvider.of<LoginBloc>(context)
                       .add(LoginUser(phonenumber: phnumber.toString()));
                    
                  }else if (name
                      .toString()
                      .contains('A user with that username already exists.')) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GetStart(
                                  areadyexist: true,
                                  username: state.username.toString(),
                                  email: state.gmail.toString(),
                                )),
                        (route) => false);
                    print('name');
                  }
                }
              })
            ],
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/Image/GetStartedBackground.png"),
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
                      left: constraints.maxWidth * 0.095,
                      child: const Column(
                        children: [
                          Text(
                            "Phone Number",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 63,
                      margin: EdgeInsets.only(
                          top: constraints.maxHeight * 0.2,
                          left: constraints.maxWidth * 0.10,
                          right: 40),
                      child: InternationalPhoneNumberInput(
                        autoFocus: true,
                        onInputChanged: (PhoneNumber number) {
                          print(number.phoneNumber);
                        },
                        onInputValidated: (bool value) {
                          print(value);
                        },
                        selectorConfig: const SelectorConfig(
                          leadingPadding: 20,
                          setSelectorButtonAsPrefixIcon: true,
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: const TextStyle(color: Colors.black),
                        initialValue: number,
                        maxLength: 12,
                        textFieldController: phoneNumber,
                        formatInput: true,
                        keyboardType: TextInputType.phone,
                        searchBoxDecoration: InputDecoration(
                            suffixIconColor: AppColor.bordergreyColor,
                            focusColor: AppColor.bordergreyColor,
                            suffixIcon: const Icon(Icons.search_rounded),
                            hintStyle: TextStyle(color: AppColor.textgreyColor),
                            hintText: "Search Countrys",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                        inputDecoration: InputDecoration(
                            fillColor: AppColor.backgroundWhite,
                            focusColor: AppColor.backgroundWhite,
                            hintStyle: TextStyle(color: AppColor.textgreyColor),
                            hintText: "Phone Number",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onSaved: (PhoneNumber number) {
                          print('On Saved: $number');
                        },
                      ),
                    ),
                    isCheckLogin == true
                        ? Positioned(
                            left: constraints.maxWidth * 0.12,
                            top: constraints.maxHeight * 0.28,
                            child: const Text(
                              "there is no user associated with! \nplease condsider reqister a new account.",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              ),
                            ),
                          )
                        : Positioned(
                            left: constraints.maxWidth * 0.12,
                            top: constraints.maxHeight * 0.28,
                            child: const Text("")),
                    Positioned(
                      top: constraints.maxHeight * 0.55,
                      left: constraints.maxWidth * 0.1,
                      right: constraints.maxWidth * 0.1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            phnumber = phoneNumber.text;
                            phnumber = phnumber!.replaceAll(' ', '');
                            phnumber =
                                phnumber!.replaceAll(RegExp(r'^0+(?=.)'), '');
                            phnumber = "855$phnumber";
                            print("phone:${phnumber}");
                          });
                          if (widget.isRegister!) {
                            print("email:${widget.email}");
                            widget.username =
                                widget.username!.replaceAll(' ', '');
                            print("name:${widget.username}");
                            BlocProvider.of<AuthregisterBloc>(context).add(
                                UserRegister(
                                    username: widget.username.toString(),
                                    email: widget.email.toString(),
                                    phonenumber: phnumber.toString()));
                            showDialogLogin(context);
                          } else {
                            showDialogLogin(context);
                            BlocProvider.of<LoginBloc>(context).add(
                                LoginUser(phonenumber: phnumber.toString()));
                          }
                          // Navigator.pushAndRemoveUntil(
                          // context,
                          // MaterialPageRoute(
                          //     builder: (_) => const ActivateScreen()),
                          // (context) => false);
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
                    )
                  ]),
                );
              },
            ),
          )),
    );
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

  void pop(context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.number = number;
    });
  }
}
