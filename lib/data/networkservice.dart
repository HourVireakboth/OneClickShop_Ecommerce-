import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:oneclickshop/model/Products/product.dart';
import 'package:oneclickshop/model/address/address.dart';
import 'package:oneclickshop/model/favorite/favorite.dart';
import '../model/cart/cartmodel.dart';

class NetworkApiService {
  int? StatusCode;
  int? RegisterCode;
  Future<dynamic> AuthUserLogin(String phonenumber, String url) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(url));
      request.body = json.encode({"phone_number": phonenumber});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        //print(await response.stream.bytesToString());
        var res = await response.stream.bytesToString();
        return json.decode(res);
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> AuthUserRegister(requestModel, String url) async {
    print("requestModel= $requestModel");
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(url));
      request.body = json.encode(requestModel);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        RegisterCode = response.statusCode;
        //print(await response.stream.bytesToString());
        var res = await response.stream.bytesToString();
        return json.decode(res);
      } else if (response.statusCode == 400) {
      //  print(await response.stream.bytesToString());
        RegisterCode = response.statusCode;
        print("Phonenumber or Username Already exist!");
        var res = await response.stream.bytesToString();
        return json.decode(res);
      } else {
        //print(response.reasonPhrase);
        var res = await response.stream.bytesToString();
        return json.decode(res);
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> AuthUserVerfiySMS(String verfiycode, String url) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(url));
      request.body = json.encode({"otp": verfiycode});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
        var res = await response.stream.bytesToString();
        return json.decode(res);
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> getProduct(String token, String url) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'token $token'
      };
      var request = http.Request('GET', Uri.parse(url));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
        var res = await response.stream.bytesToString();
        return json.decode(res);
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> getCart(String token, String url) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Token $token'
      };
      var request = http.Request('GET', Uri.parse(url));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        //print(await response.stream.bytesToString());
        print('test1');
        var res = await response.stream.bytesToString();
        //return json.decode(res);
        List<CartItemModel> result = [];
        (json.decode(res.toString())).forEach((element) {
          result.add(CartItemModel.fromJson(element));
        });
        return result;
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> addCart(requestModel, String token, String url) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Token $token',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(url));
      request.body = json.encode(requestModel);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> updateCart(requestModel, String token, String url) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Token $token',
        'Content-Type': 'application/json'
      };
      var request = http.Request('PUT', Uri.parse(url));
      request.body = json.encode(requestModel);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> deleteCart(String token, String url) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Token $token',
        'Content-Type': 'application/json'
      };
      var request = http.Request('DELETE', Uri.parse(url));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> addFavorite(String token, int productId, String url) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Token $token',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(url));
      request.body = json.encode({"product": productId});
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 201) {
        // print(await response.stream.bytesToString());
        var res = await response.stream.bytesToString();
        //print("response add  = $res");
        return json.decode(res);
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> deleteFavorite(String token, String url) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Token $token',
        'Content-Type': 'application/json'
      };
      var request = http.Request('DELETE', Uri.parse(url));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        // print(await response.stream.bytesToString());
        var res = await response.stream.bytesToString();
        return json.decode(res);
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> getAllFavorite(String token, String url) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Token $token',
        'Content-Type': 'application/json'
      };
      var request = http.Request('GET', Uri.parse(url));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        //print(await response.stream.bytesToString());
        print('getALLFavorite');
        var res = await response.stream.bytesToString();
        //return json.decode(res);
        List<FavoriteModel> result = [];
        (json.decode(res.toString())).forEach((element) {
          result.add(FavoriteModel.fromJson(element));
        });
        return result;
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> getAllAddress(String token, String url) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'token $token'
      };
      var request = http.Request('GET', Uri.parse(url));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
        print('getAllAddress');
        var res = await response.stream.bytesToString();
        //return json.decode(res);
        List<AddressModel> result = [];
        (json.decode(res.toString())).forEach((element) {
          result.add(AddressModel.fromJson(element));
        });
        return result;
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> addAddress(String token, String url, String contactname,
      String street, String province) async {
    print("");
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'token $token',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(url));
      request.body = json.encode({
        "contact_name": contactname,
        "street": street,
        "province": province
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        //print(await response.stream.bytesToString());
        var res = await response.stream.bytesToString();
        return json.decode(res);
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> updataAddress(String token, String url, String contactname,
      String street, String province) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'token $token',
        'Content-Type': 'application/json'
      };
      var request = http.Request('PUT', Uri.parse(url));
      request.body = json.encode({
        "contact_name": contactname,
        "street": street,
        "province": province
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        //print(await response.stream.bytesToString());
        var res = await response.stream.bytesToString();
        return json.decode(res);
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> deleteAddress(String token, String url) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'token $token'
      };
      var request = http.Request('DELETE', Uri.parse(url));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        //print(await response.stream.bytesToString());
        var res = await response.stream.bytesToString();
        return json.decode(res);
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> makePayment(String token, String url) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Token $token'
      };
      var request = http.Request('POST', Uri.parse(url));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        //print(await response.stream.bytesToString());
        var res = await response.stream.bytesToString();
        return json.decode(res);
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> showOrderRecord(String token, String url) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Token $token'
      };
      var request = http.Request('GET', Uri.parse(url));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        /// print(await response.stream.bytesToString());
        var res = await response.stream.bytesToString();
        return json.decode(res);
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> searchProduct(String token, String url) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'token $token'
      };
      var request = http.Request('GET', Uri.parse(url));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
        List<Result> result = [];
        var res = await response.stream.bytesToString();
        (json.decode(res.toString())).forEach((element) {
          result.add(Result.fromJson(element));
        });
        return result;
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> userInformation(String token, String url) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'token $token'
      };
      var request = http.Request('GET', Uri.parse(url));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        //print(await response.stream.bytesToString());
        var res = await response.stream.bytesToString();
        return json.decode(res);
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> updateuserInformation(
      String token, String url, String name, String email) async {
    // print("token = $token");
    // print("email = $email");
    // print("name = $name");
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'token $token',
        'Content-Type': 'application/json'
      };
      var request = http.Request('PUT', Uri.parse(url));
      request.body = json.encode({"username": "$name", "email": "$email"});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        //print(await response.stream.bytesToString());
        print("completed response");
        StatusCode = response.statusCode;
        var res = await response.stream.bytesToString();
        return json.decode(res);
      } else if (response.statusCode == 400) {
        StatusCode = response.statusCode;
        var res = await response.stream.bytesToString();
        return json.decode(res);
      } else {
        print("completed not response");
        print("state code = ${response.statusCode}");
        print(response.reasonPhrase);
      }
    } on SocketException {
      print("No internet during communication");
    }
  }

  Future<dynamic> updateUserProfile(String token, String url, pathfile) async {
    // print("pathfile = $pathfile");
    // print("token = $token");
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'token $token'
      };
      var request = http.MultipartRequest('PUT', Uri.parse(url));
      request.files
          .add(await http.MultipartFile.fromPath('image', '$pathfile'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print("UpdatePhoto");
        //print(await response.stream.bytesToString());
        var res = await response.stream.bytesToString();
        return json.decode(res);
      } else {
        print("NoUpdatePhoto");
        print(response.reasonPhrase);
      }
    } on SocketException {
      print("No internet during communication");
    }
  }
}
