

import 'package:oneclickshop/res/appurl/appurl.dart';

import '../../data/networkservice.dart';

class SearchRepository {
  NetworkApiService apiService = NetworkApiService();
  Future<dynamic> searchProduct(String token,String name) async {
    try {
      var repsonse = await apiService.searchProduct(token,ApiUrl.searchProduct + "$name");
      print("search repsonse = $repsonse");
      return repsonse;
    } catch (e) {
      rethrow;
    }
  }

}