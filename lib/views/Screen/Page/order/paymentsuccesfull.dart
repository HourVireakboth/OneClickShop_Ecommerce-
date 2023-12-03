import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneclickshop/views/Screen/Page/order/my_order.dart';

import '../../../../viewmodel/order/order_bloc.dart';

class PaymentSuccessfull extends StatefulWidget {
  PaymentSuccessfull({this.token, super.key});
  String? token;
  @override
  State<PaymentSuccessfull> createState() => _PaymentSuccessfullState();
}

class _PaymentSuccessfullState extends State<PaymentSuccessfull> {
  Future getValidationData() async {
    print("token = ${widget.token}");
    BlocProvider.of<OrderBloc>(context)
        .add(FetchOrderRecords(token: widget.token));
  }

  @override
  void initState() {
    getValidationData().whenComplete(() {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(
                builder: (context) => MyOrder(
                      ischeck: true,
                    )),
            (route) => false);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/Image/SuccessFul Payment.png"))),
      ),
    );
  }
}
