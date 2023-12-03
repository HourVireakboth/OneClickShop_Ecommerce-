// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:oneclickshop/model/showOrderRecord/showorder_record.dart';
import 'package:oneclickshop/res/appurl/appurl.dart';
import 'package:oneclickshop/viewmodel/order/order_bloc.dart';
import 'package:oneclickshop/views/Screen/Page/page.dart';

import '../../../../misc/color.dart';

class MyOrder extends StatefulWidget {
  MyOrder({this.ischeck, this.token, super.key});
  bool? ischeck;
  String? token;
  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  // List<String>? listOrderNo = [];
  // Future getValidationData() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     listOrderNo = (prefs.getStringList("orderNo") as List<String>);
  //   });
  // }

  List<bool> isDropdown = [];
  List<bool> isDropdownhistory = [];
  @override
  void initState() {
    // getValidationData().whenComplete(() {
    //   listOrderNo = listOrderNo?.map((i) => i.toString()).toList();
    //   if (widget.ischeck == false) {

    //   }
    // });
    if(widget.ischeck!){
      
    }else{
    print("test 99");
    print("token = ${widget.token}");
    BlocProvider.of<OrderBloc>(context)
        .add(FetchOrderRecords(token: widget.token));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backgroundWhite,
      body: Container(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: size.height * 0.1,
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    if (widget.ischeck == false) {
                                      Navigator.pop(context);
                                    } else {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PageMain()),
                                          (route) => false);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 29,
                                  )),
                              const SizedBox(width: 20),
                              const Text(
                                "My order",
                                style: TextStyle(
                                    fontSize: 29, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Text(
                                "",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.textgreyColor),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Active",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * 0.012,
                      ),
                      BlocConsumer<OrderBloc, OrderState>(
                        listener: (context, state) {
                          // TODO: implement listener
                          print("state = ${state}");
                        },
                        builder: (context, state) {
                          if (state is OrderCompleted) {
                            Set<int> uniqueOrderIds = {};
                            List<ResultOrders>? uniqueOrders = [];
                            for (var orderData
                                in state.showOrderRecordModel!.resultOrders!) {
                              // Extract order ID
                              int orderId = orderData.order!.id!;
                              // Check if the order ID is not in the Set (not a duplicate)
                              if (!uniqueOrderIds.contains(orderId)) {
                                // Add the order to the new list
                                String dateString =
                                    orderData.order!.deliveredDate.toString();

                                // Parse the date string
                                DateTime dateTime = DateTime.parse(dateString);

                                // Format the date to display only the date portion
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(dateTime);

                                String formattedDatenow =
                                    DateFormat('yyyy-MM-dd')
                                        .format(DateTime.now());

                                // Print the formatted date
                                print("datecompleted = $formattedDate");
                                print("datenow = $formattedDatenow");
                                if (dateTime.millisecondsSinceEpoch >=
                                    DateTime.now().millisecondsSinceEpoch) {
                                  uniqueOrders.add(orderData);
                                  // Add the order ID to the Set to mark it as encountered
                                  uniqueOrderIds.add(orderId);
                                }
                              }
                            }
                            print("orderlist = ${uniqueOrders.length}");
                            uniqueOrders.forEach((element) {
                              isDropdown.add(false);
                            });
                            return uniqueOrders.isEmpty
                                ? Container(
                                    height: 130,
                                    child: const Center(
                                        child: Text("No Order Records.")),
                                  )
                                : Container(
                                    height: size.height * 0.55,
                                    width: size.width,
                                    child: ListView.builder(
                                        itemCount: uniqueOrders.length,
                                        padding: const EdgeInsets.only(
                                            bottom: 20, left: 5, right: 5),
                                        itemBuilder: (context, index) {
                                          List<String> imageurl = [];
                                          double totalprice = 0;
                                          int imageid = int.parse(
                                              "${state.showOrderRecordModel?.resultOrders?[index].imageId}");
                                          state.showOrderRecordModel
                                              ?.resultOrders!
                                              .forEach(
                                            (element) {
                                              if (element.order!.id! ==
                                                  uniqueOrders[index]
                                                      .order!
                                                      .id) {
                                                imageurl.add(element.product!
                                                    .images![imageid].image!);
                                                totalprice = totalprice +
                                                    double.parse(
                                                        element.total!);
                                              }
                                            },
                                          );
                                          print("total price= $totalprice");
                                          print(
                                              "imageurlls=${imageurl.length}");
                                          String datenow =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(DateTime.now());
                                          String pendingdateString =
                                              uniqueOrders[index]
                                                  .order!
                                                  .pendingDate
                                                  .toString();
                                          // Parse the date string
                                          DateTime pendingdateTime =
                                              DateTime.parse(pendingdateString);
                                          // Format the date to display only the date portion
                                          String pedingDate =
                                              DateFormat('yyyy-MMMM-dd')
                                                  .format(pendingdateTime);

                                          String shippingdateString =
                                              uniqueOrders[index]
                                                  .order!
                                                  .shippedDate
                                                  .toString();
                                          // Parse the date string
                                          DateTime shippingdateTime =
                                              DateTime.parse(
                                                  shippingdateString);
                                          // Format the date to display only the date portion
                                          String shippingDate =
                                              DateFormat('yyyy-MMMM-dd')
                                                  .format(shippingdateTime);

                                          String delivereddateString =
                                              uniqueOrders[index]
                                                  .order!
                                                  .deliveredDate
                                                  .toString();
                                          // Parse the date string
                                          DateTime delivereddateTime =
                                              DateTime.parse(
                                                  delivereddateString);
                                          // Format the date to display only the date portion
                                          String deliveredDate =
                                              DateFormat('yyyy-MMMM-dd')
                                                  .format(delivereddateTime);

                                          return Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, bottom: 20),
                                            clipBehavior: Clip.antiAlias,
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 0,
                                                top: 20,
                                                bottom: 10),
                                            height: isDropdown[index] == true
                                                ? 500
                                                : 90,
                                            width: 380,
                                            decoration: BoxDecoration(
                                              color: AppColor.backgroundWhite,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(
                                                      0.2), //color of shadow
                                                  spreadRadius:
                                                      5, //spread radius
                                                  blurRadius: 7, // blur radius
                                                  offset: const Offset(0,
                                                      2), // changes position of shadow
                                                  //first paramerter of offset is left-right
                                                  //second parameter is top to down
                                                )
                                              ],
                                            ),
                                            child: Stack(
                                              children: [
                                                Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Order No.${uniqueOrders[index].order!.id}",
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              "\$${totalprice}0 - $pedingDate",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: AppColor
                                                                      .textgreyColor),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              size.width * 0.03,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .all(0),
                                                                height: 55,
                                                                width: 120,
                                                                child: ListView
                                                                    .builder(
                                                                        scrollDirection: Axis
                                                                            .horizontal,
                                                                        itemCount: imageurl
                                                                            .length,
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            right:
                                                                                0,
                                                                            left:
                                                                                10),
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return Container(
                                                                              margin: const EdgeInsets.only(right: 10),
                                                                              child: Image.network(
                                                                                "${ApiUrl.main}${imageurl[index].toString()}",
                                                                                height: 50,
                                                                                width: 50,
                                                                                fit: BoxFit.cover,
                                                                              ));
                                                                        })),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    isDropdown[index] == true
                                                        ? Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 40,
                                                                    left: 10,
                                                                    right: 10),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          20,
                                                                      width: 20,
                                                                      decoration: ShapeDecoration(
                                                                          shape:
                                                                              const CircleBorder(),
                                                                          color: pendingdateTime.millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch
                                                                              ? AppColor.backgroudButtonColor
                                                                              : AppColor.backgroundgrey),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 3,
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          100,
                                                                      width: 1,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              color: AppColor.backgroundgrey),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 3,
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          20,
                                                                      width: 20,
                                                                      decoration: ShapeDecoration(
                                                                          shape:
                                                                              const CircleBorder(),
                                                                          color: shippingdateTime.millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch
                                                                              ? AppColor.backgroudButtonColor
                                                                              : AppColor.backgroundgrey),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 3,
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          100,
                                                                      width: 1,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              color: AppColor.backgroundgrey),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 3,
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          20,
                                                                      width: 20,
                                                                      decoration: ShapeDecoration(
                                                                          shape:
                                                                              const CircleBorder(),
                                                                          color: delivereddateTime.millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch
                                                                              ? AppColor.backgroudButtonColor
                                                                              : AppColor.backgroundgrey),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      size.width *
                                                                          0.1,
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Image
                                                                            .asset(
                                                                          "assets/Image/logistics.png",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              30,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              size.width * 0.1,
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            const Text(
                                                                              "Packed",
                                                                              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            SizedBox(
                                                                              height: size.height * 0.01,
                                                                            ),
                                                                            Text(
                                                                              "Order No.${uniqueOrders[index].order!.id}",
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColor.textgreyColor),
                                                                            ),
                                                                            SizedBox(
                                                                              height: size.height * 0.01,
                                                                            ),
                                                                            Text(
                                                                              "$pedingDate",
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColor.textgreyColor),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: size
                                                                              .height *
                                                                          0.04,
                                                                    ),
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Image
                                                                            .asset(
                                                                          "assets/Image/delivery_processpng.png",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              30,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              size.width * 0.1,
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            const Text(
                                                                              "Shipping",
                                                                              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            SizedBox(
                                                                              height: size.height * 0.01,
                                                                            ),
                                                                            Text(
                                                                              "Order No.${uniqueOrders[index].order!.id}",
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColor.textgreyColor),
                                                                            ),
                                                                            SizedBox(
                                                                              height: size.height * 0.01,
                                                                            ),
                                                                            Text(
                                                                              shippingdateTime.millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch ? "$shippingDate" : "Pending Shipping...",
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColor.textgreyColor),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: size
                                                                              .height *
                                                                          0.04,
                                                                    ),
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Image
                                                                            .asset(
                                                                          "assets/Image/delivery_done.png",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              30,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              size.width * 0.1,
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            const Text(
                                                                              "Delivered",
                                                                              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            SizedBox(
                                                                              height: size.height * 0.01,
                                                                            ),
                                                                            Text(
                                                                              "Order No.${uniqueOrders[index].order!.id}",
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColor.textgreyColor),
                                                                            ),
                                                                            SizedBox(
                                                                              height: size.height * 0.01,
                                                                            ),
                                                                            Text(
                                                                              delivereddateTime.millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch ? "$deliveredDate" : "Pending Delivered...",
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColor.textgreyColor),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
                                                Positioned(
                                                  right: 5,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          if (isDropdown[
                                                              index]) {
                                                            isDropdown[index] =
                                                                false;
                                                          } else {
                                                            isDropdown[index] =
                                                                true;
                                                          }
                                                        });
                                                      },
                                                      icon: isDropdown[index] ==
                                                              false
                                                          ? const Icon(
                                                              Icons
                                                                  .arrow_drop_up_sharp,
                                                              size: 25,
                                                            )
                                                          : const Icon(
                                                              Icons
                                                                  .arrow_drop_down_sharp,
                                                              size: 25,
                                                            )),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  );
                          } else {
                            return Container(
                              width: size.width,
                              height: size.height * 0.5,
                              child: Center(
                                child: Text(
                                  "No Order Records.",
                                  style: TextStyle(
                                      color: AppColor.textgreyColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      const Text(
                        "History",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      BlocConsumer<OrderBloc, OrderState>(
                        listener: (context, state) {
                          // TODO: implement listener
                          print("state = ${state}");
                        },
                        builder: (context, state) {
                          if (state is OrderCompleted) {
                            Set<int> uniqueOrderIds = {};
                            List<ResultOrders>? uniqueOrders = [];
                            for (var orderData
                                in state.showOrderRecordModel!.resultOrders!) {
                              // Extract order ID
                              int orderId = orderData.order!.id!;
                              // Check if the order ID is not in the Set (not a duplicate)
                              if (!uniqueOrderIds.contains(orderId)) {
                                // Add the order to the new list
                                String dateString =
                                    orderData.order!.deliveredDate.toString();

                                // Parse the date string
                                DateTime dateTime = DateTime.parse(dateString);

                                // Format the date to display only the date portion
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(dateTime);

                                String formattedDatenow =
                                    DateFormat('yyyy-MM-dd')
                                        .format(DateTime.now());

                                // Print the formatted date
                                print("datecompleted = $formattedDate");
                                print("datenow = $formattedDatenow");
                                if (dateTime.millisecondsSinceEpoch <
                                    DateTime.now().millisecondsSinceEpoch) {
                                  uniqueOrders.add(orderData);
                                  // Add the order ID to the Set to mark it as encountered
                                  uniqueOrderIds.add(orderId);
                                }
                              }
                            }
                            print("orderlist = ${uniqueOrders.length}");
                            uniqueOrders.forEach((element) {
                              isDropdownhistory.add(false);
                            });
                            return uniqueOrders.isEmpty
                                ? Container(
                                    child: const Center(
                                        child: Text("No history Order.")),
                                  )
                                : Container(
                                    height: size.height * 0.55,
                                    width: size.width,
                                    child: ListView.builder(
                                        itemCount: uniqueOrders.length,
                                        padding: const EdgeInsets.only(
                                            bottom: 20, left: 5, right: 5),
                                        itemBuilder: (context, index) {
                                          List<String> imageurl = [];
                                          double totalprice = 0;
                                          int imageid = int.parse(
                                              "${state.showOrderRecordModel?.resultOrders?[index].imageId}");
                                          state.showOrderRecordModel
                                              ?.resultOrders!
                                              .forEach(
                                            (element) {
                                              if (element.order!.id! ==
                                                  uniqueOrders[index]
                                                      .order!
                                                      .id) {
                                                imageurl.add(element.product!
                                                    .images![imageid].image!);
                                                totalprice = totalprice +
                                                    double.parse(
                                                        element.total!);
                                              }
                                            },
                                          );
                                          print("total price= $totalprice");
                                          print(
                                              "imageurlls=${imageurl.length}");
                                          String datenow =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(DateTime.now());
                                          String pendingdateString =
                                              uniqueOrders[index]
                                                  .order!
                                                  .pendingDate
                                                  .toString();
                                          // Parse the date string
                                          DateTime pendingdateTime =
                                              DateTime.parse(pendingdateString);
                                          // Format the date to display only the date portion
                                          String pedingDate =
                                              DateFormat('yyyy-MMMM-dd')
                                                  .format(pendingdateTime);

                                          String shippingdateString =
                                              uniqueOrders[index]
                                                  .order!
                                                  .shippedDate
                                                  .toString();
                                          // Parse the date string
                                          DateTime shippingdateTime =
                                              DateTime.parse(
                                                  shippingdateString);
                                          // Format the date to display only the date portion
                                          String shippingDate =
                                              DateFormat('yyyy-MMMM-dd')
                                                  .format(shippingdateTime);

                                          String delivereddateString =
                                              uniqueOrders[index]
                                                  .order!
                                                  .deliveredDate
                                                  .toString();
                                          // Parse the date string
                                          DateTime delivereddateTime =
                                              DateTime.parse(
                                                  delivereddateString);
                                          // Format the date to display only the date portion
                                          String deliveredDate =
                                              DateFormat('yyyy-MMMM-dd')
                                                  .format(delivereddateTime);

                                          return Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, bottom: 20),
                                            clipBehavior: Clip.antiAlias,
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 0,
                                                top: 20,
                                                bottom: 10),
                                            height:
                                                isDropdownhistory[index] == true
                                                    ? 500
                                                    : 90,
                                            width: 380,
                                            decoration: BoxDecoration(
                                              color: AppColor.backgroundWhite,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(
                                                      0.2), //color of shadow
                                                  spreadRadius:
                                                      5, //spread radius
                                                  blurRadius: 7, // blur radius
                                                  offset: const Offset(0,
                                                      2), // changes position of shadow
                                                  //first paramerter of offset is left-right
                                                  //second parameter is top to down
                                                )
                                              ],
                                            ),
                                            child: Stack(
                                              children: [
                                                Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Order No.${uniqueOrders[index].order!.id}",
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              "\$${totalprice}0 - $pedingDate",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: AppColor
                                                                      .textgreyColor),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              size.width * 0.03,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .all(0),
                                                                height: 55,
                                                                width: 120,
                                                                child: ListView
                                                                    .builder(
                                                                        scrollDirection: Axis
                                                                            .horizontal,
                                                                        itemCount: imageurl
                                                                            .length,
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            right:
                                                                                0,
                                                                            left:
                                                                                10),
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return Container(
                                                                              margin: const EdgeInsets.only(right: 10),
                                                                              child: Image.network(
                                                                                "${ApiUrl.main}${imageurl[index].toString()}",
                                                                                height: 50,
                                                                                width: 50,
                                                                                fit: BoxFit.cover,
                                                                              ));
                                                                        })),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    isDropdownhistory[index] ==
                                                            true
                                                        ? Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 40,
                                                                    left: 10,
                                                                    right: 10),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          20,
                                                                      width: 20,
                                                                      decoration: ShapeDecoration(
                                                                          shape:
                                                                              const CircleBorder(),
                                                                          color: pendingdateTime.millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch
                                                                              ? AppColor.backgroudButtonColor
                                                                              : AppColor.backgroundgrey),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 3,
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          100,
                                                                      width: 1,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              color: AppColor.backgroundgrey),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 3,
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          20,
                                                                      width: 20,
                                                                      decoration: ShapeDecoration(
                                                                          shape:
                                                                              const CircleBorder(),
                                                                          color: shippingdateTime.millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch
                                                                              ? AppColor.backgroudButtonColor
                                                                              : AppColor.backgroundgrey),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 3,
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          100,
                                                                      width: 1,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              color: AppColor.backgroundgrey),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 3,
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          20,
                                                                      width: 20,
                                                                      decoration: ShapeDecoration(
                                                                          shape:
                                                                              const CircleBorder(),
                                                                          color: delivereddateTime.millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch
                                                                              ? AppColor.backgroudButtonColor
                                                                              : AppColor.backgroundgrey),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      size.width *
                                                                          0.1,
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Image
                                                                            .asset(
                                                                          "assets/Image/logistics.png",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              30,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              size.width * 0.1,
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            const Text(
                                                                              "Packed",
                                                                              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            SizedBox(
                                                                              height: size.height * 0.01,
                                                                            ),
                                                                            Text(
                                                                              "Order No.${uniqueOrders[index].order!.id}",
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColor.textgreyColor),
                                                                            ),
                                                                            SizedBox(
                                                                              height: size.height * 0.01,
                                                                            ),
                                                                            Text(
                                                                              "$pedingDate",
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColor.textgreyColor),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: size
                                                                              .height *
                                                                          0.04,
                                                                    ),
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Image
                                                                            .asset(
                                                                          "assets/Image/delivery_processpng.png",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              30,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              size.width * 0.1,
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            const Text(
                                                                              "Shipping",
                                                                              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            SizedBox(
                                                                              height: size.height * 0.01,
                                                                            ),
                                                                            Text(
                                                                              "Order No.${uniqueOrders[index].order!.id}",
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColor.textgreyColor),
                                                                            ),
                                                                            SizedBox(
                                                                              height: size.height * 0.01,
                                                                            ),
                                                                            Text(
                                                                              shippingdateTime.millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch ? "$shippingDate" : "Pending Shipping...",
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColor.textgreyColor),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: size
                                                                              .height *
                                                                          0.04,
                                                                    ),
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Image
                                                                            .asset(
                                                                          "assets/Image/delivery_done.png",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              30,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              size.width * 0.1,
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            const Text(
                                                                              "Delivered",
                                                                              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            SizedBox(
                                                                              height: size.height * 0.01,
                                                                            ),
                                                                            Text(
                                                                              "Order No.${uniqueOrders[index].order!.id}",
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColor.textgreyColor),
                                                                            ),
                                                                            SizedBox(
                                                                              height: size.height * 0.01,
                                                                            ),
                                                                            Text(
                                                                              delivereddateTime.millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch ? "$deliveredDate" : "Pending Delivered...",
                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColor.textgreyColor),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
                                                Positioned(
                                                  right: 5,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          if (isDropdownhistory[
                                                              index]) {
                                                            isDropdownhistory[
                                                                index] = false;
                                                          } else {
                                                            isDropdownhistory[
                                                                index] = true;
                                                          }
                                                        });
                                                      },
                                                      icon: isDropdownhistory[
                                                                  index] ==
                                                              false
                                                          ? const Icon(
                                                              Icons
                                                                  .arrow_drop_up_sharp,
                                                              size: 25,
                                                            )
                                                          : const Icon(
                                                              Icons
                                                                  .arrow_drop_down_sharp,
                                                              size: 25,
                                                            )),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  );
                          } else {
                            return Container(
                              width: size.width,
                              height: size.height * 0.15,
                              child: Center(
                                child: Text(
                                  "No History Order Records.",
                                  style: TextStyle(
                                      color: AppColor.textgreyColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
