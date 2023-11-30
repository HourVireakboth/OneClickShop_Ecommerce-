import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:oneclickshop/misc/color.dart';
import 'package:oneclickshop/viewmodel/address/address_bloc.dart';
import 'package:oneclickshop/viewmodel/authlogin/login_bloc.dart';
import 'package:oneclickshop/viewmodel/authregister/authregister_bloc.dart';
import 'package:oneclickshop/viewmodel/authverifysms/verifysms_bloc.dart';
import 'package:oneclickshop/viewmodel/cardadd/cartadd_bloc.dart';
import 'package:oneclickshop/viewmodel/favorite/favorite_bloc.dart';
import 'package:oneclickshop/viewmodel/order/order_bloc.dart';
import 'package:oneclickshop/viewmodel/payment/makepayment_bloc.dart';
import 'package:oneclickshop/viewmodel/product/product_bloc.dart';
import 'package:oneclickshop/viewmodel/search/search_bloc.dart';
import 'package:oneclickshop/viewmodel/userinfo/userinfo_bloc.dart';
import 'package:oneclickshop/views/Screen/Loading/splashscreen.dart';
import 'package:oneclickshop/views/Screen/authentication/Signup/activate.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51NL1fxFvNJihYHXJMdmRN9rxx3rcb7wNmetz9xuzzyWqx5PyLVtY5PN4MGS6sClp3LqP5Y6FWN638tUBKu12LNhq00HO3qFku5";
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
    SystemChrome.setSystemUIOverlayStyle(
       const  SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark
        ));
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (BuildContext context)=> LoginBloc()),
        BlocProvider<VerifysmsBloc>(create: (BuildContext context) =>VerifysmsBloc()),
        BlocProvider<AuthregisterBloc>(create: (BuildContext context) =>AuthregisterBloc()),
        BlocProvider<ProductBloc>(create: (BuildContext context) => ProductBloc()),
        BlocProvider<CartaddBloc>(create:(BuildContext context )=> CartaddBloc()),
        BlocProvider<FavoriteBloc>(create:(BuildContext context )=> FavoriteBloc()),
        BlocProvider<AddressBloc>(create:(BuildContext context )=> AddressBloc()),
        BlocProvider<MakepaymentBloc>(create:(BuildContext context )=> MakepaymentBloc()),
        BlocProvider<OrderBloc>(create:(BuildContext context )=> OrderBloc()),
        BlocProvider<SearchBloc>(create:(BuildContext context )=> SearchBloc()),
        BlocProvider<UserinfoBloc>(create:(BuildContext context )=> UserinfoBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "FreeSans",
          primaryColor: AppColor.backgroudButtonColor,),
        title: "OneClickShop",
        debugShowCheckedModeBanner: false,
        home:const SplashScreen(),
      ),
    );
  }
}




