import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneclickshop/misc/color.dart';
import 'package:oneclickshop/res/appurl/appurl.dart';
import 'package:oneclickshop/viewmodel/cardadd/cartadd_bloc.dart';
import 'package:oneclickshop/views/Screen/Page/order/order.dart';
import 'package:oneclickshop/views/Screen/Page/page.dart';
import 'package:oneclickshop/views/Screen/authentication/No_Login/widget/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? _token;
  Future getValidationData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString("istoken");
    });
  }

  @override
  void initState() {
    getValidationData().whenComplete(() {
      BlocProvider.of<CartaddBloc>(context).add(FetchCartAll(token: _token));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
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
            top: 0,
            right: 0,
            child: Image.asset(
              "assets/Image/styletopright.png",
              width: size.width * 0.28,
            ),
          ),
          Positioned(
            top: size.height * 0.065,
            child: Container(
              height: size.height * 1.1,
              width: size.width,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PageMain()),
                                (route) => false);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 29,
                          )),
                      const SizedBox(width: 20),
                      const Text(
                        "My Cart",
                        style: TextStyle(
                            fontSize: 29, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                BlocConsumer<CartaddBloc, CartaddState>(
                  listener: (context, state) {
                    print("state= ${state}");
                    // TODO: implement listener
                    if (state is CartCompleted) {
                      //print("count:${state.itemcart?[0].product!.name}");
                    }
                  },
                  builder: (context, state) {
                    if (state is CartLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is CartCompleted) {
                      //print("photo:${state.itemcart?[0].product!.images![0].image}");
                      return state.cartItemModel?.length == 0
                          ? EmptyCard(size: size)
                          : Container(
                              height: size.height * 0.75,
                              width: size.width * 1.0,
                              child: ListView.builder(
                                padding: const EdgeInsets.only(
                                    top: 30, left: 40, right: 40, bottom: 20),
                                scrollDirection: Axis.vertical,
                                itemCount: state.cartItemModel?.length,
                                itemBuilder: (context, index) {
                                  String color =state.cartItemModel?[index].color == null? ""
                                          : state.cartItemModel![index].color!;
                                  color = color.substring(0, color.length - 2);
                                  color = color.replaceFirst("#", "0xff");
                                  print("color code = $color");
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 40),
                                    padding: const EdgeInsets.only(
                                        right: 5,
                                        left: 10,
                                        top: 10,
                                        bottom: 10),
                                    height: 150,
                                    width: 355,
                                    decoration: BoxDecoration(
                                        color: AppColor.backgroundWhite,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(
                                                0.12), //color of shadow
                                            spreadRadius: 5, //spread radius
                                            blurRadius: 7, // blur radius
                                            offset: const Offset(0,
                                                1), // changes position of shadow
                                            //first paramerter of offset is left-right
                                            //second parameter is top to down
                                          ),
                                        ]),
                                    child: Row(children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        height: 115,
                                        width: 110,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColor.backgroundgrey),
                                        child: state
                                                    .cartItemModel?[index]
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${state.cartItemModel?[index].product!.name}",
                                              style:
                                                  const TextStyle(fontSize: 16),
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
                                                          int.parse(color))),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                const Text(
                                                  "Color",
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  height: 14,
                                                  width: 1,
                                                  color: AppColor.textgreyColor,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "${state.itemcart?[index].size}",
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "\$${state.cartItemModel?[index].product!.price}",
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                                const SizedBox(
                                                  width: 35,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        // totalprice = 0;
                                                        context
                                                            .read<CartaddBloc>()
                                                            .add(UpdateCart(
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
                                                                token: _token));
                                                      },
                                                      child: const Image(
                                                        image: AssetImage(
                                                            "assets/Image/IconRemove.png"),
                                                        width: 40,
                                                        height: 40,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 1),
                                                    Text(
                                                      "${state.cartItemModel?[index].quantity}",
                                                      style: const TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                    const SizedBox(
                                                      width: 1,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        //  totalprice = 0;
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
                                                            token: _token));
                                                      },
                                                      child: const Image(
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
                            );
                    } else {
                      return EmptyCard(size: size);
                    }
                  },
                )
              ]),
            ),
          )
        ],
      ),
      floatingActionButton: BlocConsumer<CartaddBloc, CartaddState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          double totalprice = 0;
          if (state is CartCompleted) {
            state.cartItemModel?.forEach((element) {
              double price = double.parse("${element.product?.price}");
              int qty = int.parse("${element.quantity}");
              totalprice = totalprice + (price * qty);
            });
            print("total:$totalprice");
            return Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
              width: size.width,
              height: 60,
              child: FloatingActionButton.extended(
                  backgroundColor: AppColor.backgroudButtonColor,
                  isExtended: true,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderScreen(
                                  token: _token,
                                )));
                  },
                  label: Text(
                    "Checkout - Total:\$ $totalprice ",
                    style: TextStyle(
                        color: AppColor.textBlackColor,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  )),
            );
          } else {
            return const Text("");
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class EmptyCard extends StatelessWidget {
  const EmptyCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 0),
      height: size.height * 1.0,
      width: size.width * 1.0,
      child: Stack(children: [
        Positioned(
          top: -size.height * 0.15,
          left: size.width * 0.1,
          right: size.width * 0.1,
          child: Image.asset(
            "assets/Image/card.png",
            width: size.width * 0.85,
            height: size.height * 0.85,
          ),
        ),
        Positioned(
            top: size.height * 0.45,
            left: size.width * 0.18,
            right: size.width * 0.18,
            child: const Text(
              "Your Card is Empty",
              style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
            )),
        Positioned(
            top: size.height * 0.55,
            left: size.width * 0.10,
            right: size.width * 0.10,
            child: GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => PageMain()),
                    (route) => false);
              },
              child: Button(
                text: "Start Browsing",
                colorBackground: AppColor.backgroudButtonColor,
                colorText: AppColor.textBlackColor,
                fontWeight: FontWeight.bold,
                textSize: 19,
                raduis: 25,
                sizeHeight: 60,
                sizeWidth: 350,
              ),
            ))
      ]),
    );
  }
}
