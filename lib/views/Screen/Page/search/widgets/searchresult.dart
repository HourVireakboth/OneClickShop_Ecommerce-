// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oneclickshop/misc/color.dart';
import 'package:oneclickshop/views/Screen/Page/categories/widgets/product_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../model/Products/product.dart';
import '../../categories/product_detials.dart';



class SearchResult extends StatefulWidget {
  SearchResult({
    super.key,
    this.lscate,
  });
  List<Result>? lscate;
  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  String? _token;
  Future getValidationData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString("istoken");
    });
  }

  @override
  void initState() {
    getValidationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
        bottom: -40,
        left: 0,
        child: Image.asset(
          "assets/Image/StyleBottom.png",
          width: 290,
          height: 260,
        ),
      ),
      Positioned(
        top: size.height * 0.075,
        child: Container(
          height: size.height * 1.0,
          width: size.width * 1.0,
          child: Column(children: <Widget>[
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
                    "Search Result",
                    style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          widget.lscate!.isEmpty ? Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 70),
              height: size.height * 0.86,
              width: size.width * 1.0,
              child:  Center(
                child: Column( children: [
                  LottieBuilder.network("https://lottie.host/01d29824-597d-4ccb-ac58-b283e97e7561/u8H2z3fRuj.json"),
                  Text("Search not found :(",style:TextStyle(color: AppColor.textgreyColor ,fontSize:  24 , fontWeight:  FontWeight.bold) ,)
                ]),
              )):Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 70),
              height: size.height * 0.86,
              width: size.width * 1.0,
              child: GridView.builder(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.lscate!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 40,
                      crossAxisCount: 2,
                      childAspectRatio: 0.75),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                      result: widget.lscate![index],
                                      token: _token,
                                    )));
                      },
                      child: CardProductCategorite(
                        result: widget.lscate![index],
                      ),
                    );
                  }),
            )
          ]),
        ),
      )
    ]));
  }
}
