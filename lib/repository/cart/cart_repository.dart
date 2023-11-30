
import 'package:oneclickshop/data/networkservice.dart';
import 'package:oneclickshop/model/cart/addcartmodel.dart';
import 'package:oneclickshop/model/cart/updatecartmodel.dart';


import '../../res/appurl/appurl.dart';

class CartRepository {
  NetworkApiService apiService = NetworkApiService();
  Future<dynamic> getCartAll(String token) async {
    try {
      var repsonse = await apiService.getCart(token, ApiUrl.getCart);
      print("response=$repsonse");
      return repsonse;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> addCart(int productid,int quantity,String color,String size,String image,String token) async {
    try {
      var addCartModel = AddCartModel(productId: productid,quantity: quantity,color: color,size: size ,image: image);
      var repsonse = await apiService.addCart(addCartModel.toJson(),token,ApiUrl.addCart);
      print("response=$repsonse");
      return repsonse;
    } catch (e) {
      rethrow;
    }
  }

   Future<dynamic> updateCart(int productid,int quantity,String color,String size,int cartId,String token) async {
    try {
      var updateCartModel = UpdataCartModel(productId: productid,quantity: quantity,color: color,size: size );
      var repsonse = await apiService.updateCart(updateCartModel.toJson(),token, ApiUrl.addCart + "$cartId");
      print("response=$repsonse");
      return repsonse;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteCart(int cartId,String token) async {
    try {
      var repsonse = await apiService.deleteCart(token, ApiUrl.addCart + "$cartId");
      print("response=$repsonse");
      return repsonse;
    } catch (e) {
      rethrow;
    }
  }


}
