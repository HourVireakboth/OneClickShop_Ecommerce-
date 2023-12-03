// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import 'package:oneclickshop/model/address/address.dart';
import 'package:oneclickshop/res/appurl/appurl.dart';
import 'package:oneclickshop/viewmodel/address/address_bloc.dart';
import 'package:oneclickshop/viewmodel/cardadd/cartadd_bloc.dart';
import 'package:oneclickshop/viewmodel/order/order_bloc.dart';
import 'package:oneclickshop/viewmodel/payment/makepayment_bloc.dart';
import 'package:oneclickshop/views/Screen/Page/address/add_new_address.dart';
import 'package:oneclickshop/views/Screen/Page/address/address.dart';
import 'package:oneclickshop/views/Screen/Page/order/my_order.dart';
import 'package:oneclickshop/views/Screen/Page/order/paymentsuccesfull.dart';
import 'package:oneclickshop/views/Screen/authentication/No_Login/widget/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../misc/color.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({this.token, super.key});
  String? token;
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // List<String>? listOrderNo = [];
  // Future getValidationData() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //   //  listOrderNo = (prefs.getStringList("orderNo") as List<String>);
  //   });
  // }

  Map<String, dynamic>? paymentIntent;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<AddressModel> addlist = [];
    double Totalprice = 0;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<MakepaymentBloc, MakepaymentState>(
        listener: (context, state) {
          print("state Makepayment = $state");
          if (state is MakepaymentCompleted) {
            // BlocProvider.of<OrderBloc>(context)
            //     .add(FetchOrderRecords(token: widget.token));
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => PaymentSuccessfull(
                          token: widget.token,
                        )),
                (route) => false);
            // List<String>? orderNo = listOrderNo?.map((i) => i.toString()).toList();
            // print("Order No = ${state.makePaymentModel!.orderNo}");
            // orderNo?.add(state.makePaymentModel!.id.toString());
            // print("Order Record = ${orderNo?.length}");
            // print("Order Record = ${orderNo?[0].toString()}");
            // orderNo = orderNo?.map((i) => i.toString()).toList();
            // setOrderNo(orderNo!);
          }
        },
        child: Stack(children: [
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
            top: size.height * 0.070,
            child: Container(
              height: size.height,
              width: size.width,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 29,
                              )),
                          const SizedBox(width: 20),
                          const Text(
                            "Order confirmation",
                            style: TextStyle(
                                fontSize: 29, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 36, bottom: 10, top: 10),
                      padding: const EdgeInsets.only(
                          right: 5, left: 10, top: 10, bottom: 10),
                      height: 150,
                      width: 355,
                      decoration: BoxDecoration(
                        color: AppColor.backgroundWhite,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.12), //color of shadow
                            spreadRadius: 5, //spread radius
                            blurRadius: 7, // blur radius
                            offset: const Offset(
                                0, 1), // changes position of shadow
                            //first paramerter of offset is left-right
                            //second parameter is top to down
                          )
                        ],
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Shipping address",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddNewAddress(
                                                    token: widget.token,
                                                    isUpdate: false,
                                                  )));
                                    },
                                    child: Text(
                                      "+Add a New address",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.textBlueWhite),
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        print("Change location");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Addresss(
                                                      token: widget.token,
                                                    )));
                                      },
                                      child: Image.asset(
                                        "assets/Image/changeaddressicon.png",
                                        width: 30,
                                        height: 30,
                                      ))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: BlocConsumer<AddressBloc, AddressState>(
                                listener: (context, state) {
                                  // TODO: implement listener
                                },
                                builder: (context, state) {
                                  if (state is AddressCompleted) {
                                    addlist.clear();
                                    state.addresslist!.forEach(
                                      (element) {
                                        if (element.thumbnail == true) {
                                          addlist.add(element);
                                        }
                                      },
                                    );
                                    return addlist.isEmpty
                                        ? Container(
                                            child: Text(
                                              "Please select a address or  New Address. Make is Default Address.",
                                              style: TextStyle(
                                                  color:
                                                      AppColor.textgreyColor),
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                                Image.asset(
                                                  "assets/Image/address.png",
                                                  width: 50,
                                                  height: 50,
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      width: 250,
                                                      child: Text(
                                                        "${addlist[0].province}, ${addlist[0].street}, Cambodia",
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                              ]);
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                            ),
                          ]),
                    ),
                    BlocConsumer<CartaddBloc, CartaddState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        if (state is CartCompleted) {
                          return state.cartItemModel?.length == 0
                              ? const Center(
                                  child: Text("Product is Empty"),
                                )
                              : Container(
                                  height: size.height * 0.45,
                                  width: size.width * 1.0,
                                  child: Column(children: [
                                    Container(
                                      height: size.height * 0.45,
                                      width: size.width * 1.0,
                                      child: ListView.builder(
                                        padding: const EdgeInsets.only(
                                            top: 20,
                                            left: 40,
                                            right: 40,
                                            bottom: 20),
                                        scrollDirection: Axis.vertical,
                                        itemCount: state.cartItemModel?.length,
                                        itemBuilder: (context, index) {
                                          String color = state
                                                      .cartItemModel?[index]
                                                      .color ==
                                                  null
                                              ? ""
                                              : state
                                                  .cartItemModel![index].color!;
                                          color = color.substring(
                                              0, color.length - 2);
                                          color =
                                              color.replaceFirst("#", "0xff");
                                          print("color code = $color");
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 30),
                                            padding: const EdgeInsets.only(
                                                right: 5,
                                                left: 10,
                                                top: 10,
                                                bottom: 10),
                                            height: 120,
                                            width: 355,
                                            decoration: BoxDecoration(
                                                color: AppColor.backgroundWhite,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(20)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(
                                                        0.12), //color of shadow
                                                    spreadRadius:
                                                        5, //spread radius
                                                    blurRadius:
                                                        7, // blur radius
                                                    offset: const Offset(0,
                                                        1), // changes position of shadow
                                                    //first paramerter of offset is left-right
                                                    //second parameter is top to down
                                                  ),
                                                ]),
                                            child: Row(children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10),
                                                height: 115,
                                                width: 110,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: AppColor
                                                        .backgroundgrey),
                                                child: state
                                                            .cartItemModel?[
                                                                index]
                                                            .product!
                                                            .images![0]
                                                            .image !=
                                                        null
                                                    ? Image.network(
                                                        "${ApiUrl.main}${state.cartItemModel?[index].product!.images![int.parse("${state.cartItemModel?[index].image}")].image}")
                                                    : null,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, left: 15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${state.cartItemModel?[index].product?.name}",
                                                      style: const TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 20,
                                                          width: 20,
                                                          decoration: ShapeDecoration(
                                                              shape:
                                                                  const CircleBorder(),
                                                              color: Color(
                                                                  int.parse(
                                                                      color))),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        const Text(
                                                          "Color",
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 14,
                                                          width: 1,
                                                          color: AppColor
                                                              .textgreyColor,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          "${state.itemcart?[index].size}",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "\$${state.cartItemModel?[index].product!.price}",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                        ),
                                                        const SizedBox(
                                                          width: 35,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                context.read<CartaddBloc>().add(UpdateCart(
                                                                    product_id: state
                                                                        .cartItemModel?[
                                                                            index]
                                                                        .product!
                                                                        .id,
                                                                    quantity: 1,
                                                                    color: state
                                                                        .cartItemModel?[
                                                                            index]
                                                                        .color,
                                                                    size: state
                                                                        .cartItemModel?[
                                                                            index]
                                                                        .size,
                                                                    cartId: state
                                                                        .cartItemModel?[
                                                                            index]
                                                                        .id,
                                                                    token: widget
                                                                        .token));
                                                              },
                                                              child:
                                                                  const Image(
                                                                image: AssetImage(
                                                                    "assets/Image/IconRemove.png"),
                                                                width: 40,
                                                                height: 40,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 1),
                                                            Text(
                                                              "${state.cartItemModel?[index].quantity}",
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          14),
                                                            ),
                                                            const SizedBox(
                                                              width: 1,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                print("test");
                                                                context.read<CartaddBloc>().add(AddCart(
                                                                    product_id: state
                                                                        .cartItemModel?[
                                                                            index]
                                                                        .product!
                                                                        .id,
                                                                    quantity: 1,
                                                                    color: state
                                                                        .cartItemModel?[
                                                                            index]
                                                                        .color,
                                                                    size: state
                                                                        .cartItemModel?[
                                                                            index]
                                                                        .size,
                                                                    image: state
                                                                        .cartItemModel?[
                                                                            index]
                                                                        .image,
                                                                    token: widget
                                                                        .token));
                                                              },
                                                              child:
                                                                  const Image(
                                                                image: AssetImage(
                                                                    "assets/Image/IconAdd.png"),
                                                                width: 40,
                                                                height: 40,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ]),
                                          );
                                        },
                                      ),
                                    ),
                                  ]),
                                );
                        } else {
                          return const Center(
                            child: Text("Product is Empty"),
                          );
                        }
                      },
                    ),
                    Container(
                      height: size.height * 0.1,
                      width: size.width * 1.0,
                      padding: const EdgeInsets.only(
                          top: 5, left: 40, right: 40, bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Summary",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Total item cost",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              BlocConsumer<CartaddBloc, CartaddState>(
                                listener: (context, state) {
                                  // TODO: implement listener
                                },
                                builder: (context, state) {
                                  Totalprice = 0;
                                  double totalprice = 0;
                                  if (state is CartCompleted) {
                                    state.cartItemModel?.forEach((element) {
                                      double price = double.parse(
                                          "${element.product?.price}");
                                      int qty =
                                          int.parse("${element.quantity}");
                                      totalprice = totalprice + (price * qty);
                                      Totalprice = totalprice;
                                    });
                                    print("total:$totalprice");
                                    return Text("\$$totalprice",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold));
                                  }
                                  return const Text("\.00",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold));
                                },
                              ),
                            ],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total shipping",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text("Free",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: size.height * 0.14,
              width: size.width * 1.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2), //color of shadow
                      spreadRadius: 5, //spread radius
                      blurRadius: 7, // blur radius
                      offset: const Offset(0, 2), // changes position of shadow
                      //first paramerter of offset is left-right
                      //second parameter is top to down
                    )
                  ]),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 35, right: 35, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                      BlocConsumer<CartaddBloc, CartaddState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          double totalprice = 0;
                          if (state is CartCompleted) {
                            state.cartItemModel?.forEach((element) {
                              double price =
                                  double.parse("${element.product?.price}");
                              int qty = int.parse("${element.quantity}");
                              totalprice = totalprice + (price * qty);
                            });
                            print("Total:$totalprice");
                            return Text("\$$totalprice",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 19));
                          }
                          return const Text("\.00",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19));
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: GestureDetector(
                    onTap: () async {
                      print("Place Order");
                      if (addlist.isEmpty){
                        showAlertDialog(context);
                      } else {
                        String payment;
                        payment = Totalprice.toString();
                        payment = payment.replaceAll(".", "");
                        await initPaymentSheet("${payment}0", widget.token!);
                      }
                    },
                    child: Button(
                      raduis: 25,
                      colorBackground: AppColor.backgroudButtonColor,
                      colorText: AppColor.textBlackColor,
                      fontWeight: FontWeight.bold,
                      textSize: 20,
                      sizeHeight: 55,
                      text: "Place Order",
                      sizeWidth: size.width * 1.0,
                    ),
                  ),
                )
              ]),
            ),
          )
        ]),
      ),
    );
  }

  Future<void> initPaymentSheet(String amount, String token) async {
    try {
      // 1. create payment intent on the server
      paymentIntent = await createPaymentIntent(amount);
      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret:
                paymentIntent?['client_secret'], //Gotten from payment intent
            style: ThemeMode.light,
            merchantDisplayName: 'Vireakboth',
            // googlePay: gpay
          ))
          .then((value) {});
      displayPaymentSheet(token);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

  displayPaymentSheet(String token) async {
    await Stripe.instance.presentPaymentSheet().then((value) {
      print('Payment successfully');
      BlocProvider.of<MakepaymentBloc>(context).add(MakePayments(token: token));
    });
  }

  createPaymentIntent(amount) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': 'USD',
      };
      http.Response response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51NL1fxFvNJihYHXJaqy7V6Iu8TviNi2v9ZU5vQA95sXwvvfxcXEPE4mUzaUetTJdBT3GvPwpVgX52eVrNjD9Pv3v00oha5ptg1',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print(json.decode(response.body));
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  void setOrderNo(List<String> orderNo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("orderNo", orderNo);
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons

    Widget continueButton = TextButton(
      child: Text("Done",
          style: TextStyle(
              color: AppColor.textBlackColor,
              fontSize: 18,
              fontWeight: FontWeight.bold)),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: AppColor.backgroudButtonColor,
      title: const Row(
        children: [
          Icon(
            Icons.location_city,
            size: 40,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Address",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          )
        ],
      ),
      content: const Text(
          "Please Select Address or Add new Address and make is Default! ,Before place Order.",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      actions: [
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
