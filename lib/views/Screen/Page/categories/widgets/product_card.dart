// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneclickshop/misc/color.dart';
import 'package:oneclickshop/model/Products/product.dart';

import '../../../../../viewmodel/favorite/favorite_bloc.dart';

class CardProductCategorite extends StatefulWidget {
  CardProductCategorite({
    super.key,
    this.result,
  });
  Result? result;
  @override
  State<CardProductCategorite> createState() => _CardProductCategoriteState();
}

class _CardProductCategoriteState extends State<CardProductCategorite> {
  bool isfavorite = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
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
                return const Text("");
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
                  style: TextStyle(fontSize: 10, color: AppColor.textgreyColor),
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
        const Positioned(
          right: 10,
          bottom: 25,
          child: Icon(Icons.add_circle_sharp),
        ),
      ]),
    );
  }
}
