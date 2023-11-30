import 'package:oneclickshop/model/favorite/favorite.dart';

import '../../data/networkservice.dart';
import '../../res/appurl/appurl.dart';

class FavoriteRepository {
  NetworkApiService apiService = NetworkApiService();
  Future<dynamic> getFavoriteAll(String token) async {
    try {
      var repsonse = await apiService.getAllFavorite(token, ApiUrl.getFavorite);
      print("response=$repsonse");
      return repsonse;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> addFavorite(String token,int productId) async {
    try {
      var repsonse = await apiService.addFavorite(token,productId,ApiUrl.getFavorite);
      print("addresponse=$repsonse");
      return FavoriteModel.fromJson(repsonse);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteFavorite(String token,String favoriteId) async {
    try {
      var repsonse = await apiService.deleteFavorite(token,ApiUrl.getFavorite +"$favoriteId");
      print("response delete =$repsonse");
      return repsonse;
    } catch (e) {
      rethrow;
    }
  }
}
