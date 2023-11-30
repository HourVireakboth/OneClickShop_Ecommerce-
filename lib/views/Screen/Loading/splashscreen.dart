import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oneclickshop/misc/color.dart';
import 'package:oneclickshop/model/Users/response/verifycoderesponsemodel.dart';
import 'package:oneclickshop/views/Screen/Page/page.dart';
import 'package:oneclickshop/views/Screen/authentication/No_Login/nologin_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? islogin;
  String? otmpsms;
  String? token;
  VerifyResponseModel? verifyResponseModel;

  Future getValidationData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      islogin = prefs.getBool("islogin");
      otmpsms = prefs.getString("otpsms");
      token = prefs.getString("istoken");
      print("isLogin = $islogin");
      print("otmpsms = $otmpsms");
      print("token = $token");

    });
  }

  @override
  void initState() {
    getValidationData().whenComplete(() async {
      Future.delayed(const Duration(seconds: 4)).then((value) {
        // BlocProvider.of<VerifysmsBloc>(context)
        //     .add(VerifySMSUser(verifycode: otmpsms.toString()));
        Navigator.of(context)
            .pushReplacement(CupertinoPageRoute(builder: (ctx) {
          return token == null ? const NoLoginSignU() : PageMain();
        }));
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(gradient: AppColor.mainAppColor),
        child: Stack(
          children: [
            Positioned(
              top: size.height * 0.24,
              left: size.width * 0.12,
              right: size.width * 0.12,
              child: SizedBox(
                height: size.height * 0.35,
                width: size.height * 0.35,
                child: Image.asset(
                  "assets/Image/Logo.png",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void setPreference() async {
  //   prefs = await SharedPreferences.getInstance();
  //   print(prefs?.getBool("islogin"));
  //   prefs!.getString("otpsms");
  // }
}
