// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneclickshop/viewmodel/address/address_bloc.dart';
import 'package:oneclickshop/viewmodel/product/product_bloc.dart';
import 'package:oneclickshop/viewmodel/userinfo/userinfo_bloc.dart';
import 'package:oneclickshop/views/Screen/Page/categories/product.dart';
import 'package:oneclickshop/views/Screen/Page/categories/product_detials.dart';
import 'package:oneclickshop/views/Screen/Page/home/widget/cartproduct.dart';
import 'package:oneclickshop/views/Screen/Page/search/searchscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../misc/color.dart';

import '../../../../viewmodel/favorite/favorite_bloc.dart';
import '../../authentication/No_Login/nologin_signup.dart';
import '../../authentication/No_Login/widget/card_promotion.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _token;
  Future getValidationData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString("istoken");
    });
  }

  late ScrollController _scrollController;
  bool _isVisible = true;
  int _selectedIndex = 0;

  int _currentPage = 0;
  bool end = false;

  Timer? timer;
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.85);

  @override
  void initState() {
    getValidationData().whenComplete(() {
      BlocProvider.of<ProductBloc>(context).add(FetchProducts(token: _token));
      BlocProvider.of<FavoriteBloc>(context).add(FetchsFavorite(token:_token));
      BlocProvider.of<AddressBloc>(context).add(FetchsAddress(token:_token));
      BlocProvider.of<UserinfoBloc>(context).add(GetUserInformation(token:_token));
    });
    super.initState();
    _isVisible = true;
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          setState(() {
            _isVisible = false;
          });
        } else if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          setState(() {
            _isVisible = true;
          });
        }
      });

    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage == lsPromotion.length - 1) {
        end = true;
      } else if (_currentPage == 0) {
        end = false;
      }
      if (end == false) {
        _currentPage++;
      } else {
        _currentPage--;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: CustomScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          expandedHeight: size.height * 0.03,
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
              background: Container(
            color: AppColor.backgroudButtonColor,
          )),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: size.height * 0.03,
            width: size.width * 1.0,
            decoration: BoxDecoration(
                color: AppColor.backgroudButtonColor,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.elliptical(60, 30),
                    bottomRight: Radius.circular(30))),
            child: Stack(clipBehavior: Clip.none, children: [
              Positioned(
                left: 40,
                right: 40,
                top: size.height * 0.001,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => SearchScreen(
                                  search: true,
                                )));
                  },
                  child: Container(
                    height: 50,
                    width: 355,
                    decoration: BoxDecoration(
                        color: AppColor.backgroundWhite,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            width: 1.0, color: AppColor.bordergreyColor)),
                    child: Row(children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Image(
                        image: AssetImage("assets/Image/iconsearch.png"),
                        width: 25,
                        height: 25,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Search",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColor.textgreyColor),
                      )
                    ]),
                  ),
                ),
              ),
            ]),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
            height: size.height * 0.28,
            child: PageView.builder(
              controller: _pageController,
              itemCount: lsPromotion.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CardPromotion(
                  image: lsPromotion[index],
                );
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 0, 25),
              child: Text(
                "Categories",
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textBlackColor),
              )),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            height: size.height * 0.24,
            child: GridView.builder(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: lsCategories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 32,
                    mainAxisSpacing: 2,
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print("index:$index");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductCategories(
                                    index: index,
                                    token: _token,
                                  )));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(0),
                      height: 85,
                      width: 85,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: 62,
                            width: 62,
                            decoration: BoxDecoration(
                                color: AppColor.backgroudButtonColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: Image(
                              image: AssetImage(lsCategories[index]),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            lsCategoriesName[index],
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 0, 0),
              child: Text(
                "Latest Arrival",
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textBlackColor),
              )),
        ),
        SliverToBoxAdapter(
            child: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProductCompleted) {
              var product = state.productModel!.results;
              return Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                height: size.height * 0.32,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.productModel!.results!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                       ProductDetails(result:product[index],token: _token,)));
                        },
                        child: CardProduct(
                          result: product![index],
                          token: _token,
                        ),
                      );
                    }),
              );
            } else {
              return Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  height: size.height * 0.32,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ));
            }
          },
        )),
      ],
    ));
  }
}
