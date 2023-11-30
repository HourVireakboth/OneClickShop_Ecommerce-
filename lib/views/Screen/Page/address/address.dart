// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneclickshop/viewmodel/address/address_bloc.dart';
import 'package:oneclickshop/views/Screen/Page/address/add_new_address.dart';

import '../../../../misc/color.dart';

class Addresss extends StatefulWidget {
  Addresss({this.token, super.key});
  String? token;
  @override
  State<Addresss> createState() => _AddresssState();
}

class _AddresssState extends State<Addresss> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
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
            left: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        padding: EdgeInsets.only(left: size.width * 0.08),
                        child: const Text(
                          "Saved address",
                          style: TextStyle(
                              fontSize: 29, fontWeight: FontWeight.bold),
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: size.width * 0.07),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddNewAddress(
                                            token: widget.token,
                                            isUpdate: false,
                                          )));
                            },
                            icon: const Icon(Icons.add, size: 28)))
                  ],
                ),
                BlocConsumer<AddressBloc, AddressState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is AddressCompleted) {
                      print("completed");
                      return state.addresslist!.isEmpty ?  Container(
                        width: size.width,
                        height: size.height * 0.8,
                        child: Center(
                                  child: Text("No Address Records.",style: TextStyle( color: AppColor.textgreyColor, fontSize: 24 , fontWeight: FontWeight.w500),),
                                ),
                      ) : Container(
                        margin: const EdgeInsets.all(0),
                        width: size.width,
                        height: size.height,
                        child: ListView.builder(
                            padding: const EdgeInsets.only(top: 30),
                            itemCount: state.addresslist?.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    left: 40, bottom: 10, top: 10, right: 40),
                                padding: const EdgeInsets.only(
                                    right: 5, left: 10, top: 10, bottom: 10),
                                height: 120,
                                width: 355,
                                decoration: BoxDecoration(
                                  color: AppColor.backgroundWhite,
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(20)),
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
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    "assets/Image/address.png",
                                                    width: 50,
                                                    height: 50,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 10),
                                                            child: Text(
                                                              "${state.addresslist?[index].province}",
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 50),
                                                          state.addresslist?[index]
                                                                      .thumbnail ==
                                                                  true
                                                              ? Container(
                                                                  width: 60,
                                                                  height: 30,
                                                                  decoration: BoxDecoration(
                                                                      color: AppColor
                                                                          .backgroundWhite,
                                                                      border: Border.all(
                                                                          color: AppColor
                                                                              .backgroudButtonColor2,
                                                                          width:
                                                                              1.5)),
                                                                  child: Center(
                                                                      child: Text(
                                                                    "Default",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .backgroudButtonColor2,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold),
                                                                  )),
                                                                )
                                                              : const Text("")
                                                        ],
                                                      ),
                                                      Container(
                                                        margin:
                                                            const EdgeInsets.only(
                                                                left: 10),
                                                        width: 210,
                                                        child: Text(
                                                          "${state.addresslist?[index].street},Cambodia",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          softWrap: false,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: AppColor
                                                                  .textgreyColor),
                                                          maxLines: 2,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        print("Change location");
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    AddNewAddress(
                                                                      isUpdate:
                                                                          true,
                                                                      token: widget
                                                                          .token,
                                                                      addressModel:
                                                                          state.addresslist?[
                                                                              index],
                                                                    )));
                                                      },
                                                      child: const Icon(
                                                        Icons.edit,
                                                        size: 30,
                                                      ))
                                                ]),
                                          ),
                                        ]),
                                    Positioned(
                                      top: -15,
                                      right: -10,
                                      child: IconButton(
                                          onPressed: () {
                                            showAlertDialog(
                                                context,
                                                state.addresslist![index].id!,
                                                widget.token!);
                                          },
                                          icon: const Icon(Icons.close)),
                                    )
                                  ],
                                ),
                              );
                            }),
                      );
                    } else {
                      return const Text("");
                    }
                  },
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  showAlertDialog(BuildContext context, int addressID, String token) {
    print("productID = $addressID");
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No",
          style: TextStyle(
              color: AppColor.textBlackColor,
              fontSize: 18,
              fontWeight: FontWeight.bold)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes",
          style: TextStyle(
              color: AppColor.textBlackColor,
              fontSize: 18,
              fontWeight: FontWeight.bold)),
      onPressed: () {
        BlocProvider.of<AddressBloc>(context)
            .add(RemoveAddress(token: token, addressID: addressID.toString()));
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: AppColor.backgroudButtonColor,
      title: const Row(
        children: [
          Icon(
            Icons.remove_circle_sharp,
            size: 40,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Remove",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          )
        ],
      ),
      content: const Text("Are you sure to remove this Address?",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
