// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:oneclickshop/misc/color.dart';

import '../../../../../viewmodel/userinfo/userinfo_bloc.dart';
import '../../../authentication/No_Login/widget/button.dart';

class ProflieScreen extends StatefulWidget {
  ProflieScreen(
      {this.name,
      this.email,
      this.image,
      this.phoneNumber,
      this.token,
      super.key});
  String? name;
  String? email;
  String? phoneNumber;
  String? image;
  String? token;
  @override
  State<ProflieScreen> createState() => _ProflieScreenState();
}

class _ProflieScreenState extends State<ProflieScreen> {
  @override
  void initState() {
    email.text = widget.email.toString();
    name.text = widget.name.toString();
    phoneNumber.text = widget.phoneNumber.toString();
    super.initState();
  }

  XFile? pickedfile;
  var uploading = false;
  var isImagePicked = false;
  var imagefile;
  var name = TextEditingController();
  var email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

  String initialCountry = 'KH';

  PhoneNumber number = PhoneNumber(isoCode: 'KH');
  bool? nameTaken;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap:FocusScope.of(context).unfocus,
      child: Scaffold(
          backgroundColor: AppColor.backgroundWhite,
          body: BlocListener<UserinfoBloc, UserinfoState>(
            listener: (context, state) {
              print("state = $state");
              if (state is UserinfoUnAuthorize) {
                print("username aready taken!");
                setState(() {
                  nameTaken = true;
                });
              }
              if (isImagePicked == true) {
                if (state is UserinfoCompleted) {
                  setState(() {
                    isImagePicked = false;
                  });
                  if (nameTaken == false) {
                    print("updated photo");
                    BlocProvider.of<UserinfoBloc>(context).add(UpdateUserProfile(
                        token: widget.token, pathfile: pickedfile!.path));
                  }
                }
              } else if (nameTaken == false) {
                print("nameTaken = $nameTaken");
                if (state is UserinfoCompleted) {
                  Navigator.pop(context);
                }
              }
            },
            child: Container(
              height: size.height * 1.0,
              width: size.width,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    expandedHeight: size.height * 0.08,
                    collapsedHeight: size.height * 0.001,
                    scrolledUnderElevation: 0,
                    backgroundColor: AppColor.backgroundWhite,
                    foregroundColor: Colors.black,
                    toolbarHeight: 0.0,
                    pinned: true,
                    automaticallyImplyLeading: false,
                    floating: true,
                    snap: true,
                    stretch: true,
                    flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                      children: [
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
                          top: -20,
                          right: 0,
                          child: Image.asset(
                            "assets/Image/styletopright.png",
                            width: 120,
                            height: 170,
                          ),
                        ),
                        Positioned(
                          top: size.height * 0.07,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: size.width * 0.05),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_ios_new_sharp,
                                      size: 28,
                                    )),
                              ),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.24),
                                  child: const Text(
                                    "Profile",
                                    style: TextStyle(
                                        fontSize: 29,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    )),
                  ),
                  SliverToBoxAdapter(
                      child: Container(
                    height: size.height * 1.0 - size.height * 0.15,
                    child: Stack(
                      children: [
                        Positioned(
                          top: size.height * 0.15,
                          right: size.width * 0.03,
                          child: Image.asset(
                            "assets/Image/circlestyle.png",
                            height: 20,
                            width: 20,
                          ),
                        ),
                        Positioned(
                          top: size.height * 0.30,
                          right: size.width * 0.03,
                          child: Image.asset(
                            "assets/Image/circlestyle.png",
                            height: 50,
                            width: 50,
                          ),
                        ),
                        Positioned(
                          top: size.height * 0.475,
                          right: size.width * 0.2,
                          child: Image.asset(
                            "assets/Image/circlestyle.png",
                            height: 50,
                            width: 50,
                          ),
                        ),
                        Positioned(
                          top: size.height * 0.575,
                          left: size.width * 0.3,
                          child: Image.asset(
                            "assets/Image/circlestyle.png",
                            height: 20,
                            width: 20,
                          ),
                        ),
                        Positioned(
                          bottom: size.height * 0.12,
                          right: 0,
                          child: Image.asset(
                            "assets/Image/circlestyle.png",
                            height: 50,
                            width: 50,
                          ),
                        ),
                        Positioned(
                          bottom: size.height * 0.02,
                          left: size.width * 0.2,
                          child: Image.asset(
                            "assets/Image/circlestyle.png",
                            height: 50,
                            width: 50,
                          ),
                        ),
                        Positioned(
                          bottom: size.height * 0.08,
                          left: size.width * 0.6,
                          child: Image.asset(
                            "assets/Image/circlestyle.png",
                            height: 20,
                            width: 20,
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              height: 260,
                              width: 260,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: isImagePicked == true
                                      ? DecorationImage(
                                          image: FileImage(imagefile),
                                          fit: BoxFit.cover)
                                      : DecorationImage(
                                          image: NetworkImage("${widget.image}"),
                                          fit: BoxFit.cover)),
                              child: Stack(children: [
                                Positioned(
                                  right: size.width * 0.1,
                                  bottom: size.height * 0.001,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: ShapeDecoration(
                                        color: AppColor.backgroudButtonColor,
                                        shape: const CircleBorder()),
                                    child: IconButton(
                                        onPressed: () {
                                          print("Pick Photo");
                                          getImageFromSource();
                                        },
                                        icon: const Icon(Icons.edit)),
                                  ),
                                ),
                              ]),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.030,
                                left: size.width * 0.095,
                                right: size.width * 0.095,
                              ),
                              child: TextFormField(
                                controller: name,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColor.backgroundWhite,
                                  hintText: "UserName",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColor.textgreyColor),
                                      borderRadius: BorderRadius.circular(30)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColor.textgreyColor),
                                      borderRadius: BorderRadius.circular(30)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColor.textgreyColor),
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            nameTaken == true
                                ? const Text(
                                    "Your name have been Taken! Try again",
                                    style: TextStyle(color: Colors.red),
                                  )
                                : const Text(""),
                            SizedBox(
                              height: size.height * 0.035,
                            ),
                            // Container(
                            //   height: 63,
                            //   margin: EdgeInsets.only(
                            //       left: size.width * 0.10,
                            //       right: size.width * 0.10,
                            //       bottom: size.height * 0.035),
                            //   child: InternationalPhoneNumberInput(
                            //     onInputChanged: (PhoneNumber number) {
                            //       print(number.phoneNumber);
                            //     },
                            //     onInputValidated: (bool value) {
                            //       print(value);
                            //     },
                            //     selectorConfig: const SelectorConfig(
                            //       leadingPadding: 20,
                            //       setSelectorButtonAsPrefixIcon: true,
                            //       selectorType:
                            //           PhoneInputSelectorType.BOTTOM_SHEET,
                            //     ),
                            //     ignoreBlank: false,
                            //     autoValidateMode: AutovalidateMode.disabled,
                            //     selectorTextStyle:
                            //         const TextStyle(color: Colors.black),
                            //     initialValue: number,
                            //     maxLength: 12,
                            //     textFieldController: phoneNumber,
                            //     formatInput: true,
                            //     keyboardType: TextInputType.phone,
                            //     searchBoxDecoration: InputDecoration(
                            //         suffixIconColor: AppColor.bordergreyColor,
                            //         focusColor: AppColor.bordergreyColor,
                            //         suffixIcon: const Icon(Icons.search_rounded),
                            //         hintStyle:
                            //             TextStyle(color: AppColor.textgreyColor),
                            //         hintText: "Search Countrys",
                            //         enabledBorder: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(30)),
                            //         focusedBorder: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(30))),
                            //     inputDecoration: InputDecoration(
                            //         fillColor: AppColor.backgroundWhite,
                            //         focusColor: AppColor.backgroundWhite,
                            //         hintStyle:
                            //             TextStyle(color: AppColor.textgreyColor),
                            //         hintText: "Phone Number",
                            //         enabledBorder: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(30)),
                            //         focusedBorder: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(30))),
                            //     onSaved: (PhoneNumber number) {
                            //       print('On Saved: $number');
                            //     },
                            //   ),
                            // ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.095,
                                  right: size.width * 0.095,
                                  bottom: size.height * 0.06),
                              child: TextFormField(
                                controller: email,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColor.backgroundWhite,
                                  hintText: "E-mail",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColor.textgreyColor),
                                      borderRadius: BorderRadius.circular(30)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColor.textgreyColor),
                                      borderRadius: BorderRadius.circular(30)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColor.textgreyColor),
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (name.text.isNotEmpty &&
                                    email.text.isNotEmpty) {
                                  print("updated");
                                  BlocProvider.of<UserinfoBloc>(context).add(
                                      UpdateUserInformation(
                                          token: widget.token,
                                          name: name.text.toString(),
                                          email: email.text.toString()));
                                  setState(() {
                                    nameTaken = false;
                                  });
                                }
                              },
                              child: Button(
                                text: "Save",
                                colorBackground: AppColor.backgroudButtonColor,
                                colorText: AppColor.textBlackColor,
                                fontWeight: FontWeight.bold,
                                textSize: 19,
                                raduis: 25,
                                sizeHeight: 60,
                                sizeWidth: 350,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          )),
    );
  }

  dynamic getImageFromSource() async {
    pickedfile = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxHeight: 1800, maxWidth: 1900);
    if (pickedfile != null) {
      setState(() {
        isImagePicked = true;
        imagefile = File(pickedfile!.path);
        print("${pickedfile!.path}");
        uploading = true;
      });
    }
  }
}
