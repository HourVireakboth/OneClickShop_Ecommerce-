// ignore_for_file: must_be_immutable
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneclickshop/helper/fromvalidate.dart';
import 'package:oneclickshop/model/address/address.dart';
import 'package:oneclickshop/viewmodel/address/address_bloc.dart';
import 'package:oneclickshop/views/Screen/authentication/No_Login/widget/button.dart';
import 'package:pinput/pinput.dart';
import '../../../../misc/color.dart';

class AddNewAddress extends StatefulWidget {
  AddNewAddress({this.token, this.addressModel, this.isUpdate, super.key});
  String? token;
  AddressModel? addressModel;
  bool? isUpdate;
  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  var contactName = TextEditingController();
  var phonenumber = TextEditingController();
  var address = TextEditingController();
  var sutie = TextEditingController();
  var province = TextEditingController();
  var city = TextEditingController();
  var zipcode = TextEditingController();
  var globalkey = GlobalKey<FormState>();
  var globalkey2 = GlobalKey<FormState>();
  var globalkey3 = GlobalKey<FormState>();
  var globalkey4 = GlobalKey<FormState>();
  var globalkey5 = GlobalKey<FormState>();
  var globalkey6 = GlobalKey<FormState>();
  var globalkey7 = GlobalKey<FormState>();
  var countryname = "Cambodia";
  var DialCode = "+855";
  var addressID;

  bool _switchValue = false;

  @override
  void initState() {
    if (widget.isUpdate!) {
      addressID = widget.addressModel!.id;
      contactName.text = widget.addressModel!.contactName!;
      address.text = widget.addressModel!.street!;
      province.text = widget.addressModel!.province!;
      _switchValue = widget.addressModel!.thumbnail!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocListener<AddressBloc, AddressState>(
            listener: (context, state) {
              if (state is AddressCompleted) {
                if (_switchValue) {
                  print("setDefault = $_switchValue");
                  _switchValue = false;
                  var addressid = state.address?.id;
                  var contactname = state.address?.contactName;
                  var street = state.address?.street;
                  var province = state.address?.province;
                  print("addressId = $addressid");
                  print("contactname = $contactname");
                  print("street = $street");
                  print("province = $province");
                  print("listiteam = ${state.iteamaddress?.length}");
                  BlocProvider.of<AddressBloc>(context).add(UpdateAddress(
                      token: widget.token,
                      addressId: addressid.toString(),
                      contactname: contactname,
                      street: street,
                      province: province));
                } else {
                  Navigator.pop(context);
                }
              }
            },
            child: Container(
              margin: const EdgeInsets.all(0),
              width: size.width,
              height: size.height * 1.0,
              child: Stack(
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
                    top: -50,
                    right: 0,
                    child: Image.asset(
                      "assets/Image/styletopright.png",
                      width: 120,
                      height: 170,
                    ),
                  ),
                  Positioned(
                      top: size.height * 0.070,
                      child: Container(
                          height: size.height,
                          width: size.width,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                        "Add New Address",
                                        style: TextStyle(
                                            fontSize: 29,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ]))),
                  Positioned(
                      top: size.height * 0.15,
                      child: Container(
                        height: size.height * 1.0,
                        width: size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Country / Region",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.height * 0.015,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 20, right: 30, bottom: 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: AppColor.textgreyColor),
                                      borderRadius: BorderRadius.circular(25)),
                                  height: 60,
                                  width: size.width * 1.0,
                                  child: CountryListPick(
                                      appBar: AppBar(
                                        iconTheme: const IconThemeData(size: 29),
                                        elevation: 0,
                                        foregroundColor: AppColor.textBlackColor,
                                        backgroundColor:
                                            AppColor.backgroudButtonColor,
                                        title: const Text(
                                          'Country List',
                                          style: TextStyle(
                                              fontSize: 29,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      theme: CountryTheme(
                                        alphabetTextColor:
                                            AppColor.textBlackColor,
                                        alphabetSelectedTextColor:
                                            AppColor.textBlackColor,
                                        alphabetSelectedBackgroundColor:
                                            AppColor.backgroudButtonColor,
                                        isShowFlag: true,
                                        isShowTitle: true,
                                        isShowCode: false,
                                        isDownIcon: false,
                                        showEnglishName: false,
                                      ),
                                      initialSelection: '+855',
                                      onChanged: (CountryCode? code) {
                                        print(code!.name);
                                        print(code.code);
                                        print(code.dialCode);
                                        print(code.flagUri);
                                        setState(() {
                                          countryname = code.name!;
                                          DialCode = code.dialCode!;
                                        });
                                      },
                                      // Whether to allow the widget to set a custom UI overlay
                                      useUiOverlay: true,
                                      // Whether the country list should be wrapped in a SafeArea
                                      useSafeArea: false),
                                ),
                                SizedBox(
                                  height: size.height * 0.015,
                                ),
                                const Text(
                                  "Personal information",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.height * 0.015,
                                ),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Form(
                                        key: globalkey,
                                        child: TextFormField(
                                          validator: (contactname) {
                                            if (contactname!.isEmpty) {
                                              return 'Please enter a Contact Name';
                                            } else {
                                              if (extString(contactname)
                                                  .isValidName) {
                                                return null;
                                              } else {
                                                return 'Invaild Contact Name';
                                              }
                                            }
                                          },
                                          onChanged: (value) {
                                            if (globalkey.currentState!
                                                .validate()) {
                                              globalkey.currentState!.save();
                                            }
                                          },
                                          onFieldSubmitted: (userInput) {
                                            if (globalkey.currentState!
                                                .validate()) {
                                              globalkey.currentState!.save();
                                            }
                                          },
                                          controller: contactName,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: AppColor.backgroundWhite,
                                            hintText: "Contact name*",
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color:
                                                        AppColor.textgreyColor),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color:
                                                        AppColor.textgreyColor),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color:
                                                        AppColor.textgreyColor),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                          ),
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: size.height * 0.015,
                                      // ),
                                      // Text(
                                      //   "$countryname ($DialCode)",
                                      //   style: const TextStyle(
                                      //       fontSize: 18,
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                      // SizedBox(
                                      //   height: size.height * 0.015,
                                      // ),
                                      // Form(
                                      //   key: globalkey2,
                                      //   child: TextFormField(
                                      //     validator: (numberphone) {
                                      //       if (numberphone!.isEmpty) {
                                      //         return 'Please enter a Mobile Number';
                                      //       } else {
                                      //         if (extString(numberphone)
                                      //             .isValidPhone) {
                                      //           return null;
                                      //         } else {
                                      //           return 'Invaild Mobile Number';
                                      //         }
                                      //       }
                                      //     },
                                      //     onChanged: (value) {
                                      //       if (globalkey2.currentState!
                                      //           .validate()) {
                                      //         globalkey2.currentState!.save();
                                      //       }
                                      //     },
                                      //     onFieldSubmitted: (userInput) {
                                      //       if (globalkey2.currentState!
                                      //           .validate()) {
                                      //         globalkey2.currentState!.save();
                                      //       }
                                      //     },
                                      //     controller: phonenumber,
                                      //     decoration: InputDecoration(
                                      //       filled: true,
                                      //       fillColor: AppColor.backgroundWhite,
                                      //       hintText: "Mobile number",
                                      //       border: OutlineInputBorder(
                                      //           borderSide: BorderSide(
                                      //               width: 1,
                                      //               color: AppColor.textgreyColor),
                                      //           borderRadius:
                                      //               BorderRadius.circular(30)),
                                      //       enabledBorder: OutlineInputBorder(
                                      //           borderSide: BorderSide(
                                      //               width: 1,
                                      //               color: AppColor.textgreyColor),
                                      //           borderRadius:
                                      //               BorderRadius.circular(30)),
                                      //       focusedBorder: OutlineInputBorder(
                                      //           borderSide: BorderSide(
                                      //               width: 1,
                                      //               color: AppColor.textgreyColor),
                                      //           borderRadius:
                                      //               BorderRadius.circular(30)),
                                      //     ),
                                      //   ),
                                      // ),
                                    ]),
                                SizedBox(
                                  height: size.height * 0.015,
                                ),
                                const Text(
                                  "Address",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.height * 0.015,
                                ),
                                Column(children: [
                                  Form(
                                    key: globalkey3,
                                    child: TextFormField(
                                      validator: (numberphone) {
                                        if (numberphone!.isEmpty) {
                                          return 'Please enter a Street,Apartment,House';
                                        } else {
                                          if (address.length >= 5) {
                                            return null;
                                          } else {
                                            return 'Street,Apartment,House must be 5 letter up';
                                          }
                                        }
                                      },
                                      onChanged: (value) {
                                        if (globalkey3.currentState!.validate()) {
                                          globalkey3.currentState!.save();
                                        }
                                      },
                                      onFieldSubmitted: (userInput) {
                                        if (globalkey3.currentState!.validate()) {
                                          globalkey3.currentState!.save();
                                        }
                                      },
                                      controller: address,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColor.backgroundWhite,
                                        hintText:
                                            "Street,house / apartment / unit",
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: AppColor.textgreyColor),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: AppColor.textgreyColor),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: AppColor.textgreyColor),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  // Form(
                                  //   key: globalkey4,
                                  //   child: TextFormField(
                                  //     validator: (numberphone) {
                                  //       if (numberphone!.isEmpty) {
                                  //         return 'Please enter a Apt,Suite,Unit';
                                  //       } else {
                                  //         if (sutie.length >= 5) {
                                  //           return null;
                                  //         } else {
                                  //           return 'Apt,Suite,Unit must be 5 letter up';
                                  //         }
                                  //       }
                                  //     },
                                  //     onChanged: (value) {
                                  //       if (globalkey4.currentState!.validate()) {
                                  //         globalkey4.currentState!.save();
                                  //       }
                                  //     },
                                  //     onFieldSubmitted: (userInput) {
                                  //       if (globalkey4.currentState!.validate()) {
                                  //         globalkey4.currentState!.save();
                                  //       }
                                  //     },
                                  //     controller: sutie,
                                  //     decoration: InputDecoration(
                                  //       filled: true,
                                  //       fillColor: AppColor.backgroundWhite,
                                  //       hintText: "Apt ,Suite, Unit, etc Optional",
                                  //       border: OutlineInputBorder(
                                  //           borderSide: BorderSide(
                                  //               width: 1,
                                  //               color: AppColor.textgreyColor),
                                  //           borderRadius:
                                  //               BorderRadius.circular(30)),
                                  //       enabledBorder: OutlineInputBorder(
                                  //           borderSide: BorderSide(
                                  //               width: 1,
                                  //               color: AppColor.textgreyColor),
                                  //           borderRadius:
                                  //               BorderRadius.circular(30)),
                                  //       focusedBorder: OutlineInputBorder(
                                  //           borderSide: BorderSide(
                                  //               width: 1,
                                  //               color: AppColor.textgreyColor),
                                  //           borderRadius:
                                  //               BorderRadius.circular(30)),
                                  //     ),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: size.height * 0.02,
                                  // ),
                                  Form(
                                    key: globalkey5,
                                    child: TextFormField(
                                      validator: (numberphone) {
                                        if (numberphone!.isEmpty) {
                                          return 'Please enter a Province';
                                        } else {
                                          if (province.length >= 2) {
                                            return null;
                                          } else {
                                            return 'Province must be 2 letter up';
                                          }
                                        }
                                      },
                                      onChanged: (value) {
                                        if (globalkey5.currentState!.validate()) {
                                          globalkey5.currentState!.save();
                                        }
                                      },
                                      onFieldSubmitted: (userInput) {
                                        if (globalkey5.currentState!.validate()) {
                                          globalkey5.currentState!.save();
                                        }
                                      },
                                      controller: province,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColor.backgroundWhite,
                                        hintText: "Province",
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: AppColor.textgreyColor),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: AppColor.textgreyColor),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: AppColor.textgreyColor),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: size.height * 0.02,
                                  // ),
                                  // Form(
                                  //   key: globalkey6,
                                  //   child: TextFormField(
                                  //     validator: (numberphone) {
                                  //       if (numberphone!.isEmpty) {
                                  //         return 'Please enter a City';
                                  //       } else {
                                  //         if (city.length >= 2) {
                                  //           return null;
                                  //         } else {
                                  //           return 'City must be 2 letter up';
                                  //         }
                                  //       }
                                  //     },
                                  //     onChanged: (value) {
                                  //       if (globalkey6.currentState!.validate()) {
                                  //         globalkey6.currentState!.save();
                                  //       }
                                  //     },
                                  //     onFieldSubmitted: (userInput) {
                                  //       if (globalkey6.currentState!.validate()) {
                                  //         globalkey6.currentState!.save();
                                  //       }
                                  //     },
                                  //     controller: city,
                                  //     decoration: InputDecoration(
                                  //       filled: true,
                                  //       fillColor: AppColor.backgroundWhite,
                                  //       hintText: "City",
                                  //       border: OutlineInputBorder(
                                  //           borderSide: BorderSide(
                                  //               width: 1,
                                  //               color: AppColor.textgreyColor),
                                  //           borderRadius:
                                  //               BorderRadius.circular(30)),
                                  //       enabledBorder: OutlineInputBorder(
                                  //           borderSide: BorderSide(
                                  //               width: 1,
                                  //               color: AppColor.textgreyColor),
                                  //           borderRadius:
                                  //               BorderRadius.circular(30)),
                                  //       focusedBorder: OutlineInputBorder(
                                  //           borderSide: BorderSide(
                                  //               width: 1,
                                  //               color: AppColor.textgreyColor),
                                  //           borderRadius:
                                  //               BorderRadius.circular(30)),
                                  //     ),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: size.height * 0.02,
                                  // ),
                                  // Form(
                                  //   key: globalkey7,
                                  //   child: TextFormField(
                                  //     validator: (numberphone) {
                                  //       if (numberphone!.isEmpty) {
                                  //         return 'Please enter a Zip code';
                                  //       } else {
                                  //         if (zipcode.length >= 6) {
                                  //           return null;
                                  //         } else {
                                  //           return 'Zip code must be 6 letter up';
                                  //         }
                                  //       }
                                  //     },
                                  //     onChanged: (value) {
                                  //       if (globalkey7.currentState!.validate()) {
                                  //         globalkey7.currentState!.save();
                                  //       }
                                  //     },
                                  //     onFieldSubmitted: (userInput) {
                                  //       if (globalkey7.currentState!.validate()) {
                                  //         globalkey7.currentState!.save();
                                  //       }
                                  //     },
                                  //     controller: zipcode,
                                  //     decoration: InputDecoration(
                                  //       filled: true,
                                  //       fillColor: AppColor.backgroundWhite,
                                  //       hintText: "ZIP code",
                                  //       border: OutlineInputBorder(
                                  //           borderSide: BorderSide(
                                  //               width: 1,
                                  //               color: AppColor.textgreyColor),
                                  //           borderRadius:
                                  //               BorderRadius.circular(30)),
                                  //       enabledBorder: OutlineInputBorder(
                                  //           borderSide: BorderSide(
                                  //               width: 1,
                                  //               color: AppColor.textgreyColor),
                                  //           borderRadius:
                                  //               BorderRadius.circular(30)),
                                  //       focusedBorder: OutlineInputBorder(
                                  //           borderSide: BorderSide(
                                  //               width: 1,
                                  //               color: AppColor.textgreyColor),
                                  //           borderRadius:
                                  //               BorderRadius.circular(30)),
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Set as default Shipping address",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      CupertinoSwitch(
                                        activeColor:
                                            AppColor.backgroudButtonColor,
                                        value: _switchValue,
                                        onChanged: (value) {
                                          setState(() {
                                            _switchValue = value;
                                            print("default:$_switchValue");
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (contactName.text.isNotEmpty &&
                                          address.text.isNotEmpty &&
                                          province.text.isNotEmpty) {
                                        if (widget.isUpdate!) {
                                          print("update");
                                          print("addid = $addressID");
                                          print(
                                              "contactname = ${contactName.text.toString()}");
                                          print(
                                              "street = ${address.text.toString()}");
                                          print(
                                              "province = ${province.text.toString()}");
                                          BlocProvider.of<AddressBloc>(context)
                                              .add(UpdateAddress(
                                                  token: widget.token,
                                                  addressId: addressID.toString(),
                                                  contactname:
                                                      contactName.text.toString(),
                                                  street: address.text.toString(),
                                                  province:
                                                      province.text.toString()));
                                          _switchValue = false;
                                        } else {
                                          context.read<AddressBloc>().add(
                                              ADDAddress(
                                                  token: widget.token,
                                                  contactname:
                                                      contactName.text.toString(),
                                                  street: address.text.toString(),
                                                  province:
                                                      province.text.toString()));
                                        }
                                      } else {
                                        showAlertDialog(context);
                                      }
                                    },
                                    child: Button(
                                      text: "Save",
                                      colorBackground:
                                          AppColor.backgroudButtonColor,
                                      colorText: AppColor.textBlackColor,
                                      fontWeight: FontWeight.bold,
                                      textSize: 19,
                                      raduis: 25,
                                      sizeHeight: 60,
                                      sizeWidth: 350,
                                    ),
                                  ),
                                ]),
                              ]),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    print("productID = $addressID");
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Done",
          style: TextStyle(
              color: AppColor.textBlackColor,
              fontSize: 18,
              fontWeight: FontWeight.bold)),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: AppColor.backgroudButtonColor,
      title: const Row(
        children: [
          Icon(
            Icons.remove_circle_sharp,
            size: 40,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Missing fields",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          )
        ],
      ),
      content: const Text("Please check again and input all fields.",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
