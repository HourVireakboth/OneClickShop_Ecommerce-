// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneclickshop/viewmodel/search/search_bloc.dart';
import 'package:oneclickshop/views/Screen/Page/search/widgets/searchresult.dart';
import 'package:oneclickshop/views/Screen/authentication/No_Login/nologin_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../misc/color.dart';
import '../categories/product.dart';
import 'widgets/choice_chip.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  SearchScreen({super.key, this.search});
  bool? search;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
  var search = TextEditingController();
  GlobalKey? globalKey;
  @override
  void initState() {
    getValidationData().whenComplete(() {});
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
  }

  List<String> chipList = [
    "Nike",
    "ASUS",
    "Apple Watch",
    "iPhone 15Pro Max",
    "Pedro",
    "Zinvo",
    "Book"
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BlocListener<SearchBloc, SearchState>(
            listener: (context, state) {
              if (state is SearchCompleted) {;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchResult(lscate: state.searchList,)));
              }
            },
            child: Stack(
              children: [
                Container(
                  width: size.width * 1.0,
                  height: size.height * 1.0,
                  child: CustomScrollView(
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
                              child: SizedBox(
                                height: 50,
                                child: TextFormField(
                                  onSaved: (newValue) {},
                                  onFieldSubmitted: (value) {
                                    print("search");
                                    BlocProvider.of<SearchBloc>(context).add(
                                        SearchProduct(
                                            token: _token,
                                            name: search.text.toString()));
                                  },
                                  cursorColor: AppColor.textgreyColor,
                                  key: globalKey,
                                  //autofocus: true,
                                  controller: search,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(0),
                                    prefixIcon: Container(
                                      margin: const EdgeInsets.only(
                                          left: 20, right: 15),
                                      child: GestureDetector(
                                        onTap: () {
                                          print("search");
                                          BlocProvider.of<SearchBloc>(context)
                                              .add(SearchProduct(
                                                  token: _token,
                                                  name: search.text.toString()));
                                        },
                                        child: const Image(
                                          width: 25,
                                          height: 25,
                                          image: AssetImage(
                                              "assets/Image/iconsearch.png"),
                                        ),
                                      ),
                                    ),
                                    hintText: "Search",
                                    hintStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.textgreyColor),
                                    filled: true,
                                    fillColor: AppColor.backgroundWhite,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: AppColor.textgreyColor),
                                        borderRadius: BorderRadius.circular(30)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: AppColor.textgreyColor),
                                        borderRadius: BorderRadius.circular(30)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: AppColor.textgreyColor),
                                        borderRadius: BorderRadius.circular(30)),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 50, 0, 10),
                            child: Text(
                              "Top Searches",
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.textBlackColor),
                            )),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(30, 0, 0, 20),
                          height: MediaQuery.sizeOf(context).height * 0.1,
                          width: MediaQuery.sizeOf(context).width,
                          child: ChoiceChipWidget(chipList),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 50, 0, 25),
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
                    ],
                  ),
                ),
                widget.search == true
                    ? Positioned(
                        top: size.height * 0.035,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.black,
                            )))
                    : const Text(""),
              ],
            ),
          )),
    );
  }
}
