// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneclickshop/viewmodel/favorite/favorite_bloc.dart';
import 'package:oneclickshop/views/Screen/Page/categories/product_detials.dart';
import 'package:oneclickshop/views/Screen/Page/user/wishlist/widgets/wishlist_card.dart';

import '../../../../../misc/color.dart';

class WishlistScreen extends StatefulWidget {
  WishlistScreen({this.token, super.key});
  String? token;
  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    BlocProvider.of<FavoriteBloc>(context)
        .add(FetchsFavorite(token: widget.token));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
          top: -20,
          right: 0,
          child: Image.asset(
            "assets/Image/styletopright.png",
            width: 120,
            height: 170,
          ),
        ),
        Positioned(
          top: size.height * 0.085,
          child: Container(
            height: size.height * 1.0,
            width: size.width * 1.0,
            child: Column(children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_sharp,
                        size: 28,
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: size.width * 0.25),
                      child: const Text(
                        "Wishlist",
                        style: TextStyle(
                            fontSize: 29, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              BlocConsumer<FavoriteBloc, FavoriteState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is FavoriteLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is FavoriteCompleted) {
                    return Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      height: size.height * 0.86,
                      width: size.width * 1.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                   
                                  )));
                        },
                        child: GridView.builder(
                            padding: const EdgeInsets.only(top: 30),
                            scrollDirection: Axis.vertical,
                            itemCount: state.itemsFavorite?.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 30,
                                    mainAxisSpacing: 40,
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.75),
                            itemBuilder: (context, index) {
                              return cardWishlist(context,
                                  state.itemsFavorite?[index], widget.token!);
                            }),
                      ),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.all(0),
                      height: size.height * 0.8,
                      width: size.height,
                      child: Center(
                        child: Text(
                          "No Whislist Records.",
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
    ));
  }
}
