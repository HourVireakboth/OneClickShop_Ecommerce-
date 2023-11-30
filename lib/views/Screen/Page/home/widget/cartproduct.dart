import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneclickshop/model/Products/product.dart';
import 'package:oneclickshop/viewmodel/favorite/favorite_bloc.dart';
import '../../../../../misc/color.dart';
import '../../categories/product_detials.dart';

// ignore: must_be_immutable
class CardProduct extends StatefulWidget {
  CardProduct({this.result, this.token, super.key});
  Result? result;
  String? token;
  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  bool isfavorite = false;
  @override
  Widget build(BuildContext context) {
    print("test10");
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 40, right: 10, bottom: 10),
      height: 200,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.backgroundWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.12), //color of shadow
            spreadRadius: 5, //spread radius
            blurRadius: 7, // blur radius
            offset: const Offset(0, 1), // changes position of shadow
            //first paramerter of offset is left-right
            //second parameter is top to down
          )
        ],
      ),
      child: Stack(children: [
        Positioned(
            top: 20,
            left: 15,
            child: Image.network(
              "${widget.result!.images![0].image}",
              width: MediaQuery.of(context).size.width * 0.3,
            )),
        Positioned(
            top: 15,
            right: 15,
            child: BlocConsumer<FavoriteBloc, FavoriteState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is FavoriteCompleted) {
                  isfavorite = false;
                  state.itemsFavorite?.forEach((element) {
                    if (element.product.toString() ==
                        widget.result?.id.toString()) {
                      isfavorite = true;
                    }
                  });
                  return isfavorite == true
                      ? Image.asset(
                          "assets/Image/farvite.png",
                          width: MediaQuery.of(context).size.width * 0.08,
                        )
                      : Image.asset(
                          "assets/Image/unfarvite.png",
                          width: MediaQuery.of(context).size.width * 0.06,
                        );
                }
                return Image.asset(
                          "assets/Image/unfarvite.png",
                          width: MediaQuery.of(context).size.width * 0.06,
                        );
              },
            )),
        Positioned(
            bottom: 50,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.result!.name}",
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  "Description",
                  style: TextStyle(fontSize: 8, color: AppColor.textgreyColor),
                ),
              ],
            )),
        Positioned(
            bottom: 20,
            left: 20,
            child: Text(
              "\$${widget.result!.price}",
              style: const TextStyle(fontSize: 20),
            )),
        Positioned(
            right: 10,
            bottom: 25,
            child: GestureDetector(
              onTap: () {
                // BlocProvider.of<CartaddBloc>(context).add(AddCart(
                //   product_id: int.parse("${widget.result!.id}"),
                //   quantity: 1,
                //   color: widget.result!.color![0].name,
                //   size: widget.result!.size![0].name,
                //   image: "0" ,
                //   token: widget.token
                // ));

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetails(
                              result: widget.result,
                              token: widget.token,
                            )));
              },
              child: const Icon(Icons.add_circle_sharp),
            )),
      ]),
    );
  }
}
