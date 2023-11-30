import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneclickshop/misc/color.dart';
import 'package:oneclickshop/model/favorite/favorite.dart';
import 'package:oneclickshop/res/appurl/appurl.dart';
import 'package:oneclickshop/viewmodel/favorite/favorite_bloc.dart';

Widget cardWishlist(
    BuildContext context, FavoriteModel? favoriteModel, String token) {
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
          child: favoriteModel?.productNested?.images?[0].image == null
              ? const Text("NO")
              : Image.network(
                  "${ApiUrl.main}${favoriteModel?.productNested?.images?[0].image}",
                  width: MediaQuery.of(context).size.width * 0.3,
                )),
      Positioned(
          top: 15,
          right: 15,
          child: GestureDetector(
            onTap: () {
              context.read<FavoriteBloc>().add(RemoveFavorite(
                  token: token, favoriteID: favoriteModel?.id.toString()));
            },
            child: Image.asset(
              "assets/Image/farvite.png",
              width: MediaQuery.of(context).size.width * 0.08,
            ),
          )),
      Positioned(
          bottom: 50,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${favoriteModel?.productNested?.name}",
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
            "\$${favoriteModel?.productNested?.price}",
            style: const TextStyle(fontSize: 20),
          )),
      Positioned(
          right: 10,
          bottom: 25,
          child: GestureDetector(
            onTap: () {},
            child: const Icon(Icons.add_circle_sharp),
          )),
    ]),
  );
}
