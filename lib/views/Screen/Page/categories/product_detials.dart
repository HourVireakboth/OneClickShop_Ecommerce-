// ignore_for_file: must_be_immutable

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oneclickshop/misc/color.dart';
import 'package:oneclickshop/model/Products/product.dart';
import 'package:oneclickshop/viewmodel/favorite/favorite_bloc.dart';

import '../../../../viewmodel/cardadd/cartadd_bloc.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({this.result, this.token, super.key});
  Result? result;
  String? token;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var controller = SwiperController();
  var selectColors = 0;
  var selectSize = 0;
  var favoriteID;
  bool isfavorite = false;
  double? rating = 4.5;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(children: [
          SizedBox(
            height: size.height * 0.50,
            child: Swiper(
              controller: controller,
              autoplay: false,
              //autoplayDelay: 1,
              itemCount: widget.result!.images!.length,
              itemBuilder: (ctx, index) {
                return SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(50)),
                    child: Image.network(
                      '${widget.result!.images![index].image}',
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
              pagination: SwiperPagination(
                  margin: const EdgeInsets.only(bottom: 15),
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                      space: 10,
                      color: AppColor.textBlackColor.withOpacity(0.6),
                      activeColor: AppColor.backgroudButtonColor)),
            ),
          ),
          Positioned(
            right: size.width * 0.06,
            top: size.height * 0.47,
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.12), //color of shadow
                      spreadRadius: 5, //spread radius
                      blurRadius: 7, // blur radius
                      offset: const Offset(0, 1), // changes position of shadow
                      //first paramerter of offset is left-right
                      //second parameter is top to down
                    )
                  ]),
              child: IconButton(
                icon: BlocConsumer<FavoriteBloc, FavoriteState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is FavoriteCompleted) {
                      state.itemsFavorite?.forEach((element) {
                        if (element.product.toString() ==
                            widget.result?.id.toString()) {
                          isfavorite = true;
                          favoriteID = element.id;
                        }
                      });
                    }
                    print("isfavorite = $isfavorite");
                    return isfavorite == false
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.grey,
                          )
                        : const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          );
                  },
                ),
                onPressed: () {
                  setState(() {
                    if (isfavorite) {
                      print("remove");
                      print("favoriteID= $favoriteID");
                      print("token= ${widget.token}");
                      isfavorite = false;
                      context.read<FavoriteBloc>().add(RemoveFavorite(
                          favoriteID: favoriteID.toString(),
                          token: widget.token));
                    } else {
                      print("Add");
                      isfavorite = true;
                      context.read<FavoriteBloc>().add(AddFavorite(
                          productID: widget.result?.id, token: widget.token));
                    }
                  });
                },
              ),
            ),
          ),

          // Detail

          Positioned(
            top: size.height * 0.55,
            child: Container(
              padding: const EdgeInsets.only(right: 35, left: 35),
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "\$${widget.result!.price}",
                    style: const TextStyle(fontSize: 25),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        "${widget.result!.name}",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          RatingBar(
                            glowColor: AppColor.ratingcolor,
                            itemSize: 25,
                            initialRating: rating!,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            ratingWidget: RatingWidget(
                              full: Icon(
                                Icons.star,
                                color: AppColor.ratingcolor,
                              ),
                              half: Icon(Icons.star_half,
                                  color: AppColor.ratingcolor),
                              empty: Icon(Icons.star_border,
                                  color: AppColor.ratingcolor),
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                this.rating = rating;
                              });
                            },
                          ),
                          Text(
                            "$rating",
                            style: const TextStyle(fontSize: 16),
                          )
                        ],
                      )
                    ],
                  ),
                  const Text(
                    'Color Option',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: size.width,
                    height: 50,
                    child: ListView.builder(
                        padding: const EdgeInsets.all(0),
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.result!.color!.length,
                        itemBuilder: (context, index) {
                          String color =
                              widget.result!.color![index].name.toString();
                          color = color.substring(0, color.length - 2);
                          color = color.replaceFirst("#", "0xff");
                          print("color code = $color");
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                controller.move(index);
                                selectColors = index;
                                print("selectColors: $selectColors");
                              });
                            },
                            child: selectColors == index
                                ? Container(
                                    margin: const EdgeInsets.all(10),
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 1, color: Colors.red),
                                        color: Colors.white),
                                    child: Container(
                                      margin: const EdgeInsets.all(3),
                                      decoration: ShapeDecoration(
                                          shape: const CircleBorder(),
                                          color: Color(int.parse(color))),
                                    ),
                                  )
                                : Container(
                                    margin: const EdgeInsets.all(10),
                                    width: 25,
                                    height: 25,
                                    decoration: ShapeDecoration(
                                        shape: const CircleBorder(),
                                        color: Color(int.parse(color))),
                                  ),
                          );
                        }),
                  ),
                  const Text(
                    'Select Size',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: size.width,
                    height: 50,
                    child: ListView.builder(
                        padding: const EdgeInsets.all(0),
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.result!.size!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectSize = index;
                                print("selectSize = $selectSize");
                              });
                            },
                            child: selectSize == index
                                ? Container(
                                    margin: const EdgeInsets.all(10),
                                    width: 60,
                                    height: 42,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                            width: 1, color: Colors.red),
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                      width: 60,
                                      height: 42,
                                      child: Center(
                                          child: Text(
                                              "${widget.result!.size![index].name}")),
                                    ))
                                : Container(
                                    margin: const EdgeInsets.all(10),
                                    width: 60,
                                    height: 42,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                            width: 1, color: Colors.black),
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                      width: 60,
                                      height: 42,
                                      child: Center(
                                          child: Text(
                                              "${widget.result!.size![index].name}")),
                                    )),
                          );
                        }),
                  ),
                  const Text(
                    'Decription',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                   Text(
                    '${widget.result!.description}',
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: size.height * 0.05,
            child: SizedBox(
              height: 85,
              width: 240,
              child: CupertinoButton(
                color: AppColor.backgroudButtonColor,
                onPressed: () {
                  context.read<CartaddBloc>().add(AddCart(
                      product_id: widget.result!.id,
                      quantity: 1,
                      color: widget.result!.color![selectColors].name,
                      size: widget.result!.size![selectSize].name,
                      image: selectColors.toString(),
                      token: widget.token));
                },
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(30)),
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: AppColor.textBlackColor,
                    ),
                    Text(
                      "Add to Cart",
                      style: TextStyle(
                          fontSize: 17, color: AppColor.textBlackColor),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              left: size.width * 0.05,
              top: size.height * 0.08,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 35,
                  )))
        ]),
      ),
    );
  }

  List<int> lsSize = [
    38,
    39,
    40,
    41,
    42,
  ];

  List<Color> lscolor = [
    Colors.black,
    Colors.red,
    Colors.yellow,
  ];
}
