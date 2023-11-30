import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:oneclickshop/misc/color.dart';
import 'package:oneclickshop/service/auth_service.dart';
import 'package:oneclickshop/views/Screen/authentication/Login/widget/button_login.dart';
import 'package:oneclickshop/views/Screen/authentication/No_Login/nologin_signup.dart';
import 'package:oneclickshop/views/Screen/authentication/Signup/signup.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/Image/Login.png"),
                    fit: BoxFit.cover)),
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Stack(children: [
              Positioned(
                  top: constraints.maxHeight * 0.075,
                  left: constraints.maxWidth * 0.08,
                  child: GestureDetector(
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
                  )),
              Positioned(
                bottom: 110,
                left: 20,
                right: 20,
                child: Container(
                  margin: const EdgeInsets.all(0),
                  height: constraints.maxHeight * 0.39,
                  width: constraints.maxWidth * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Buttonlogin(constraints, "assets/Image/iconfacebook.png",
                          "Continue With FaceBook"),
                      GestureDetector(
                        onTap: () {
                          Future<bool> googleLogin =
                              AuthService().signInwithGoogel();
                          googleLogin.then((result) {
                            if (result) {
                              print("gmail = ${AuthService.gmail}");
                              print("name = ${AuthService.gname}");
                              var gmail = AuthService.gmail;
                              var name = AuthService.gname;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupScreen(username: name, email: gmail, isRegister: true)));
                            }
                          });
                        },
                        child: Buttonlogin(
                            constraints,
                            "assets/Image/icongoogle.png",
                            "Continue With Google"),
                      ),
                      Buttonlogin(constraints, "assets/Image/iconapple.png",
                          "Continue With Apple"),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 1,
                              width: 145,
                              color: AppColor.textBlackColor,
                            ),
                            Text(
                              "or",
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.textBlackColor),
                            ),
                            Container(
                              height: 1,
                              width: 145,
                              color: AppColor.textBlackColor,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen(isRegister: false,)));
                        },
                        child: Buttonlogin(
                            constraints,
                            "assets/Image/iconcall.png",
                            "Continue With Moblie Number"),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          );
        },
      ),
    );
  }
}
