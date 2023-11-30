// ignore: duplicate_ignore
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneclickshop/misc/color.dart';
import 'package:oneclickshop/model/Products/product.dart';
import 'package:oneclickshop/viewmodel/product/product_bloc.dart';
import 'package:oneclickshop/views/Screen/Page/categories/widgets/product_card.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'product_detials.dart';


class ProductCategories extends StatefulWidget {
  ProductCategories({
    super.key,
    this.index,
    this.token,
  });
  int? index;
  String? token;
  @override
  _ProductCategoriesState createState() => _ProductCategoriesState();
}

class _ProductCategoriesState extends State<ProductCategories>
    with TickerProviderStateMixin {
  // TickerProviderStateMixin allows the fade out/fade in animation when changing the active button

  // this will control the button clicks and tab changing
  TabController? _controller;

  // this will control the animation when a button changes from an off state to an on state
  AnimationController? _animationControllerOn;

  // this will control the animation when a button changes from an on state to an off state
  AnimationController? _animationControllerOff;

  // this will give the background color values of a button when it changes to an on state
  Animation? _colorTweenBackgroundOn;
  Animation? _colorTweenBackgroundOff;

  // this will give the foreground color values of a button when it changes to an on state
  Animation? _colorTweenForegroundOn;
  Animation? _colorTweenForegroundOff;

  // when swiping, the _controller.index value only changes after the animation, therefore, we need this to trigger the animations and save the current index
  int _currentIndex = 0;

  // saves the previous active tab
  int _prevControllerIndex = 0;

  // saves the value of the tab animation. For example, if one is between the 1st and the 2nd tab, this value will be 0.5
  double _aniValue = 0.0;

  // saves the previous value of the tab animation. It's used to figure the direction of the animation
  double _prevAniValue = 0.0;

  // these will be our tab icons. You can use whatever you like for the content of your buttons
  List _icons = [
    "Books",
    "Shoes",
    "Laptops",
    "Watches",
    "Phones",
    "Clothes",
    "Electronics",
    "Accessories",
  ];

  List<Result>? catebook = [];
  List<Result>? catelaptop = [];
  List<Result>? catephone = [];
  List<Result>? cateelectronics = [];
  List<Result>? cateshoes = [];
  List<Result>? catewatchs = [];
  List<Result>? cateclothes = [];
  List<Result>? cateaccessories = [];

  // active button's foreground color
  Color _foregroundOn = AppColor.textBlackColor;
  Color _foregroundOff = AppColor.textBlackColor;

  // active button's background color
  Color _backgroundOn = AppColor.backgroudButtonColor;
  Color? _backgroundOff = AppColor.backgroundWhite;

  // scroll controller for the TabBar
  ScrollOffsetController _scrollController = ScrollOffsetController();
  ItemScrollController itemScrollController = ItemScrollController();
  // ScrollController _scrollController = ScrollController();

  // this will save the keys for each Tab in the Tab Bar, so we can retrieve their position and size for the scroll controller
  List _keys = [];

  // regist if the the button was tapped
  bool _buttonTap = false;
  int indexTitle = 0;

  Future getValidationData() async {
    //BlocProvider.of<ProductBloc>(context).add(FetchProducts(token: widget.token));
    indexTitle = widget.index!;
    _currentIndex = widget.index!;
    print("currentIndex = $_currentIndex");
    for (int index = 0; index < _icons.length; index++) {
      // create a GlobalKey for each Tab
      _keys.add(GlobalKey());
    }
    // itemScrollController.scrollTo(index: 5 , duration:  Duration.zero);
    // this creates the controller with 6 tabs (in our case)
    _controller = TabController(
        vsync: this, length: _icons.length, initialIndex: _currentIndex);
    // this will execute the function every time there's a swipe animation
    _controller!.animation!.addListener(_handleTabAnimation);
    // this will execute the function every time the _controller.index value changes
    _controller!.addListener(_handleTabChange);

    _animationControllerOff =
        AnimationController(vsync: this, duration: Duration(milliseconds: 75));
    // so the inactive buttons start in their "final" state (color)
    _animationControllerOff!.value = 1.0;
    _colorTweenBackgroundOff =
        ColorTween(begin: _backgroundOn, end: _backgroundOff)
            .animate(_animationControllerOff!);
    _colorTweenForegroundOff =
        ColorTween(begin: _foregroundOn, end: _foregroundOff)
            .animate(_animationControllerOff!);

    _animationControllerOn =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    // so the inactive buttons start in their "final" state (color)
    _animationControllerOn!.value = 1.0;
    _colorTweenBackgroundOn =
        ColorTween(begin: _backgroundOff, end: _backgroundOn)
            .animate(_animationControllerOn!);
    _colorTweenForegroundOn =
        ColorTween(begin: _foregroundOff, end: _foregroundOn)
            .animate(_animationControllerOn!);
  }

  ProductModel? productModel;
  @override
  void initState() {
    super.initState();
    getValidationData().whenComplete(() {
      itemScrollController.jumpTo(index: widget.index!);
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
                    Text(
                      "${_icons[indexTitle]}",
                      style: const TextStyle(
                          fontSize: 29, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              // this is the TabBar
              Container(
                  height: 100.0,
                  padding: const EdgeInsets.only(top: 22, bottom: 22),
                  // this generates our tabs buttons
                  child: ScrollablePositionedList.builder(
                      // this gives the TabBar a bounce effect when scrolling farther than it's size
                      physics: const BouncingScrollPhysics(),
                      scrollOffsetController: _scrollController,
                      itemScrollController: itemScrollController,
                      // make the list horizontal
                      scrollDirection: Axis.horizontal,
                      // number of tabs
                      itemCount: _icons.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            // each button's key
                            key: _keys[index],
                            // padding for the buttons
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              margin: const EdgeInsets.all(0),
                              width: 120,
                              child: ButtonTheme(
                                  child: AnimatedBuilder(
                                animation: _colorTweenBackgroundOn!,
                                builder: (context, child) => ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    side: MaterialStateProperty.all(BorderSide(
                                        width: _getBackgroundColor(index) ==
                                                AppColor.backgroudButtonColor
                                            ? 0
                                            : 1,
                                        color: _getBackgroundColor(index) ==
                                                AppColor.backgroudButtonColor
                                            ? Colors.transparent
                                            : AppColor.textgreyColor)),
                                    backgroundColor: MaterialStateProperty.all(
                                        _getBackgroundColor(
                                            index)), // get the color of the button's background (dependent of its state)
                                    // make the button a rectangle with round corners
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      print(" index = $index");
                                      indexTitle = index;
                                      _buttonTap = true;
                                      // trigger the controller to change between Tab Views
                                      _controller!.animateTo(index);
                                      // set the current index
                                      _setCurrentIndex(index);
                                      // scroll to the tapped button (needed if we tap the active button and it's not on its position)
                                      _scrollTo(index);
                                    });
                                  },
                                  child: Text(
                                    "${_icons[index]}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: _getForegroundColor(index)),
                                  ),
                                ),
                              )),
                            ));
                      })),
              Flexible(
                  // this will host our Tab Views
                  child: BlocConsumer<ProductBloc, ProductState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is ProductCompleted) {
                    var product = state.productModel!.results;
                    print("productcount: ${product!.length}");
                    for (int i = 0; i < product.length; i++) {
                      if (state.productModel!.results![i].category?.name
                              .toString() ==
                          "Books") {
                        catebook!.add(product[i]);
                      } else if (state.productModel!.results![i].category?.name
                              .toString() ==
                          "Laptops") {
                        catelaptop!.add(product[i]);
                      } else if (state.productModel!.results![i].category?.name
                              .toString() ==
                          "Phones") {
                        catephone!.add(product[i]);
                      } else if (state.productModel!.results![i].category?.name
                              .toString() ==
                          "Electronics") {
                        cateelectronics!.add(product[i]);
                      } else if (state.productModel!.results![i].category?.name
                              .toString() ==
                          "Shoes") {
                        cateshoes!.add(product[i]);
                      } else if (state.productModel!.results![i].category?.name
                              .toString() ==
                          "Watches") {
                        catewatchs!.add(product[i]);
                      } else if (state.productModel!.results![i].category?.name
                              .toString() ==
                          "Clothes") {
                        cateclothes!.add(product[i]);
                      } else if (state.productModel!.results![i].category?.name
                              .toString() ==
                          "Accessories") {
                        cateaccessories!.add(product[i]);
                      }
                    }
                    //catelaptop = catelaptop!.toSet().toList();
                    return TabBarView(
                      // and it is controlled by the controller
                      controller: _controller,
                      children: <Widget>[
                        // our Tab Views
                        GridViewProduct(
                          size: size,
                          lscate: catebook,
                        ),
                        GridViewProduct(size: size, lscate: cateshoes,token: widget.token,),
                        GridViewProduct(size: size, lscate: catelaptop,token: widget.token,),
                        GridViewProduct(size: size, lscate: catewatchs,token: widget.token,),
                        GridViewProduct(size: size, lscate: catephone,token: widget.token,),
                        GridViewProduct(size: size, lscate: cateclothes,token: widget.token,),
                        GridViewProduct(size: size, lscate: cateelectronics,token: widget.token,),
                        GridViewProduct(size: size, lscate: cateaccessories,token: widget.token,),
                      ],
                    );
                  } else {
                    // Default Loading
                    return TabBarView(
                      // and it is controlled by the controller
                      controller: _controller,
                      children: const <Widget>[
                        // our Tab Views
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    );
                  }
                },
              )),
            ]),
          ),
        )
      ]),
    );
  }

  // runs during the switching tabs animation
  _handleTabAnimation() {
    // gets the value of the animation. For example, if one is between the 1st and the 2nd tab, this value will be 0.5
    _aniValue = _controller!.animation!.value;

    // if the button wasn't pressed, which means the user is swiping, and the amount swipped is less than 1 (this means that we're swiping through neighbor Tab Views)
    if (!_buttonTap && ((_aniValue - _prevAniValue).abs() < 1)) {
      // set the current tab index
      _setCurrentIndex(_aniValue.round());
    }

    // save the previous Animation Value
    _prevAniValue = _aniValue;
  }

  // runs when the displayed tab changes
  _handleTabChange() {
    // if a button was tapped, change the current index
    if (_buttonTap) _setCurrentIndex(_controller!.index);

    // this resets the button tap
    if ((_controller!.index == _prevControllerIndex) ||
        (_controller!.index == _aniValue.round())) _buttonTap = false;

    // save the previous controller index
    _prevControllerIndex = _controller!.index;
  }

  _setCurrentIndex(int index) {
    // if we're actually changing the index
    if (index != _currentIndex) {
      setState(() {
        // change the index
        clearCateList();
        _currentIndex = index;
      });

      // trigger the button animation
      _triggerAnimation();
      // scroll the TabBar to the correct position (if we have a scrollable bar)
      _scrollTo(index);
    }
  }

  _triggerAnimation() {
    // reset the animations so they're ready to go
    _animationControllerOn!.reset();
    _animationControllerOff!.reset();

    // run the animations!
    _animationControllerOn!.forward();
    _animationControllerOff!.forward();
  }

  _scrollTo(int index) {
    // get the screen width. This is used to check if we have an element off screen
    double screenWidth = MediaQuery.of(context).size.width;

    // get the button we want to scroll to
    RenderBox renderBox = _keys[index].currentContext.findRenderObject();
    // get its size
    double size = renderBox.size.width;
    // and position
    double position = renderBox.localToGlobal(Offset.zero).dx;

    // this is how much the button is away from the center of the screen and how much we must scroll to get it into place
    double offset = (position + size / 2) - screenWidth / 2;

    // if the button is to the left of the middle
    if (offset < 0) {
      // get the first button
      renderBox = _keys[0].currentContext.findRenderObject();
      // get the position of the first button of the TabBar
      position = renderBox.localToGlobal(Offset.zero).dx;

      // if the offset pulls the first button away from the left side, we limit that movement so the first button is stuck to the left side
      if (position > offset) offset = position;
    } else {
      // if the button is to the right of the middle

      // get the last button
      renderBox = _keys[_icons.length - 1].currentContext.findRenderObject();
      // get its position
      position = renderBox.localToGlobal(Offset.zero).dx;
      // and size
      size = renderBox.size.width;

      // if the last button doesn't reach the right side, use it's right side as the limit of the screen for the TabBar
      if (position + size < screenWidth) screenWidth = position + size;

      // if the offset pulls the last button away from the right side limit, we reduce that movement so the last button is stuck to the right side limit
      if (position + size - offset < screenWidth) {
        offset = position + size - screenWidth;
      }
    }

    // scroll the calculated ammount
    _scrollController.animateScroll(
        offset: offset,
        duration: new Duration(milliseconds: 150),
        curve: Curves.easeInOut);
  }

  _getBackgroundColor(int index) {
    if (index == _currentIndex) {
      // if it's active button
      return _colorTweenBackgroundOn!.value;
    } else if (index == _prevControllerIndex) {
      // if it's the previous active button
      return _colorTweenBackgroundOff!.value;
    } else {
      // if the button is inactive
      return _backgroundOff;
    }
  }

  _getForegroundColor(int index) {
    // the same as the above
    if (index == _currentIndex) {
      return _colorTweenForegroundOn!.value;
    } else if (index == _prevControllerIndex) {
      return _colorTweenForegroundOff!.value;
    } else {
      return _foregroundOff;
    }
  }

  void clearCateList() {
    catelaptop!.clear();
    catebook!.clear();
    cateclothes!.clear();
    cateaccessories!.clear();
    cateshoes!.clear();
    catewatchs!.clear();
    catephone!.clear();
    cateelectronics!.clear();
  }
}

class GridViewProduct extends StatefulWidget {
  GridViewProduct({
    super.key,
    required this.size,
    this.lscate,
    this.token,
  });
  List<Result>? lscate;
  final Size size;
  String? token;
  @override
  State<GridViewProduct> createState() => _GridViewProductState();
}

class _GridViewProductState extends State<GridViewProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 70),
      height: widget.size.height * 0.86,
      width: widget.size.width * 1.0,
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
                              token: widget.token,
                            )));
              },
              child: CardProductCategorite(
                result: widget.lscate![index],
              ),
            );
          }),
    );
  }
}
