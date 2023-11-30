import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:oneclickshop/misc/color.dart';

import '../../../authentication/No_Login/widget/button.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  var name = TextEditingController();

  final TextEditingController phoneNumber = TextEditingController();

  String initialCountry = 'KH';

  PhoneNumber number = PhoneNumber(isoCode: 'KH');
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColor.backgroundWhite,
        body: Container(
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
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_back_ios_new_sharp,
                                  size: 28,
                                )),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: size.width * 0.27),
                              child: const Text(
                                "Help",
                                style: TextStyle(
                                    fontSize: 29, fontWeight: FontWeight.bold),
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
                      bottom: size.height * 0.08 ,
                      left: size.width * 0.6,
                      child: Image.asset(
                        "assets/Image/circlestyle.png",
                        height: 20,
                        width: 20,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: size.width * 0.095,
                                right: size.width * 0.095,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           const Padding(
                            padding:  EdgeInsets.only(left: 20),
                            child:  Text("Send Message", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                            SizedBox(height: size.height * 0.03,),
                           TextFormField(
                              controller: name,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColor.backgroundWhite,
                                hintText: "UserName",
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
                            SizedBox(height: size.height * 0.04,),
                           TextFormField(
                              controller: name,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColor.backgroundWhite,
                                hintText: "E-mail",
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
                             SizedBox(height: size.height * 0.04,),
                            TextFormField(
                              controller: name,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColor.backgroundWhite,
                                hintText: "Subject",
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
                             SizedBox(height: size.height * 0.04,),
                            SizedBox(
                              height: size.height * 0.15,
                              child: TextFormField(
                                maxLines: null,
                                expands: true,
                                keyboardType: TextInputType.multiline,
                                controller: name,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                                  filled: true,
                                  fillColor: AppColor.backgroundWhite,
                                  hintText: "Message",
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
                      SizedBox(height: size.height * 0.015,),
                       Row(children: [
                           const Icon(Icons.location_on),
                           const SizedBox(width:10 ,),
                            Text("Street 99 PoChenTong Morkot,Phnom penh",style: TextStyle(color: AppColor.textgreyColor ,fontSize: 12, fontWeight: FontWeight.bold),)
                          ],),
                      SizedBox(height: size.height * 0.015,),
                 const Padding(
                            padding:  EdgeInsets.only(left: 0),
                            child:  Text("Call US", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                            SizedBox(height: size.height * 0.015,),
                       Row(children: [
                           const Icon(Icons.call),
                           const SizedBox(width:10 ,),
                            Text("+855 967383551",style: TextStyle(color: AppColor.textgreyColor ,fontSize: 12, fontWeight: FontWeight.bold),)
                          ],),
                          SizedBox(height: size.height * 0.015,),
                      Row(children: [
                           const Icon(Icons.call),
                           const SizedBox(width:10 ,),
                            Text("+855 11638381",style: TextStyle(color: AppColor.textgreyColor ,fontSize: 12, fontWeight: FontWeight.bold),)
                          ],),
                          SizedBox(height: size.height * 0.015,),  
                      const Padding(
                            padding:  EdgeInsets.only(left: 0),
                            child:  Text("Email", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                            SizedBox(height: size.height * 0.015,),     
                      Row(children: [
                           const Icon(Icons.email),
                           const SizedBox(width:10 ,),
                            Text("hourvireakboth88@gmail.com",style: TextStyle(color: AppColor.textgreyColor ,fontSize: 12, fontWeight: FontWeight.bold),)
                          ],),
                      SizedBox(height: size.height * 0.015,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                             Button(
                              text: "Send",
                              colorBackground: AppColor.backgroudButtonColor,
                              colorText: AppColor.textBlackColor,
                              fontWeight: FontWeight.bold,
                              textSize: 19,
                              raduis: 25,
                              sizeHeight: 40,
                              sizeWidth: 160,
                            ),
                          ],


                        )
                            
                        ],
                      ),
                    ),
                                  ],
                                ),
                  ))
            ],
          ),
        ));
  }
}
