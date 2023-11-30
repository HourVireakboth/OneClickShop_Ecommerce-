import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneclickshop/misc/color.dart';
import 'package:oneclickshop/res/appurl/appurl.dart';
import 'package:oneclickshop/viewmodel/favorite/favorite_bloc.dart';
import 'package:oneclickshop/viewmodel/userinfo/userinfo_bloc.dart';
import 'package:oneclickshop/views/Screen/Page/address/address.dart';
import 'package:oneclickshop/views/Screen/Page/order/my_order.dart';
import 'package:oneclickshop/views/Screen/Page/user/profile/profile.dart';
import 'package:oneclickshop/views/Screen/Page/user/wishlist/wishlist.dart';
import 'package:oneclickshop/views/Screen/authentication/No_Login/nologin_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String? _token;
  Future getValidationData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString("istoken");
    });
  }

  @override
  void initState() {
    getValidationData().whenComplete(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          height: size.height * 1.0,
          width: size.width * 1.0,
          child: Stack(
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
                top: size.height * 0.25,
                right: 50,
                child: Image.asset(
                  "assets/Image/circlestyle.png",
                  height: 50,
                  width: 50,
                ),
              ),
              Positioned(
                top: size.height * 0.6,
                right: size.width * 0.08,
                child: Image.asset(
                  "assets/Image/circlestyle.png",
                  height: 50,
                  width: 50,
                ),
              ),
              Positioned(
                bottom: size.height * 0.06,
                right: size.width * 0.15,
                child: Image.asset(
                  "assets/Image/circlestyle.png",
                  height: 40,
                  width: 40,
                ),
              ),
              Positioned(
                bottom: size.height * 0.02,
                left: size.width * 0.02,
                child: Image.asset(
                  "assets/Image/circlestyle.png",
                  height: 30,
                  width: 30,
                ),
              ),
              Positioned(
                top: size.height * 0.085,
                left: size.width * 0.07,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Account",
                      style:
                          TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("Edit profile 1");
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        height: 115,
                        width: 355,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.backgroundWhite,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.12), //color of shadow
                                spreadRadius: 5, //spread radius
                                blurRadius: 7, // blur radius
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                                //first paramerter of offset is left-right
                                //second parameter is top to down
                              )
                            ]),
                        child: BlocConsumer<UserinfoBloc, UserinfoState>(
                          listener: (context, state) {
                            // TODO: implement listener
                          },
                          builder: (context, state) {
                            if (state is UserinfoCompleted) {
                              String? name =
                                  state.userinfor!.username.toString();
                              String? email = state.userinfor?.email.toString();

                              String? image = state.userinfor?.image.toString();

                              String? phonenumber =
                                  state.userinfor?.phoneNumber.toString();
                              return Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    height: 95,
                                    width: 95,
                                    decoration: ShapeDecoration(
                                        color: AppColor.textgreyColor,
                                        shape: const CircleBorder(),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "${state.userinfor?.image}"),
                                            fit: BoxFit.cover)),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${state.userinfor?.username}",
                                          style: const TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(0),
                                          width: 150,
                                          child: Text(
                                            "${state.userinfor?.email}",
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.textgreyColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProflieScreen(
                                                      token: _token,
                                                      phoneNumber: phonenumber,
                                                      name: name,
                                                      email: email,
                                                      image: image)));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 30),
                                      height: 25,
                                      width: 25,
                                      decoration: ShapeDecoration(
                                          color: AppColor.textBlackColor,
                                          shape: const CircleBorder()),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: AppColor.backgroundWhite,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: size.height * 0.3,
                child: Container(
                  width: size.width * 1.0,
                  height: size.height * 0.55,
                  //  margin: const EdgeInsets.only(left: 30, top: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.14),
                        child: GestureDetector(
                          onTap: () async {
                            print("My Order");
                            // final SharedPreferences prefs =
                            //     await SharedPreferences.getInstance();
                            // prefs.remove("orderNo");

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyOrder(
                                          token: _token,
                                          ischeck: false,
                                        )));
                          },
                          child: const Row(
                            children: [
                              ImageIcon(
                                AssetImage("assets/Image/MyOrder.png"),
                                size: 30,
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                "My Order",
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.14),
                        child: GestureDetector(
                          onTap: () {
                            print("Wishlist");
                          },
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WishlistScreen(
                                            token: _token,
                                          )));
                            },
                            child: const Row(
                              children: [
                                ImageIcon(
                                  AssetImage("assets/Image/Wishlist.png"),
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  "Wishlist",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      BlocConsumer<FavoriteBloc, FavoriteState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          if (state is FavoriteCompleted) {
                            return Container(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              height: size.height * 0.12,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.itemsFavorite?.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.only(left: 20),
                                      height: 115,
                                      width: 110,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColor.backgroundgrey),
                                      child: Image.network(
                                        "${ApiUrl.main}${state.itemsFavorite![index].productNested?.images?[0].image}",
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }),
                            );
                          } else {
                            return Center(
                              child: Text(
                                "No Whislist Records.",
                                style: TextStyle(
                                    color: AppColor.textgreyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            );
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.14),
                        child: const Row(
                          children: [
                            ImageIcon(
                              AssetImage("assets/Image/Browsing History .png"),
                              size: 30,
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Text(
                              "Browsing History",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.14),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Addresss(token: _token)));
                          },
                          child: const Row(
                            children: [
                              ImageIcon(
                                AssetImage("assets/Image/addressicon.png"),
                                size: 30,
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                "Saved address",
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.14),
                        child: const Row(
                          children: [
                            ImageIcon(
                              AssetImage("assets/Image/helpicon.png"),
                              size: 30,
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Text(
                              "Help",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.14),
                        child: const Row(
                          children: [
                            ImageIcon(
                              AssetImage("assets/Image/Accout Setting.png"),
                              size: 30,
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Text(
                              "Account Setting",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.14),
                        child: GestureDetector(
                          onTap: () async {
                            print("test1");
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.remove('islogin');
                            prefs.remove('otpsms');
                            prefs.remove('istoken');
                            // ignore: use_build_context_synchronously
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const NoLoginSignU()),
                                (route) => false);
                          },
                          child: const Row(
                            children: [
                              ImageIcon(
                                AssetImage("assets/Image/Logout.png"),
                                size: 30,
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                "Logout",
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
