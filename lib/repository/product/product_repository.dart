import 'package:oneclickshop/data/networkservice.dart';
import 'package:oneclickshop/model/Products/product.dart';
import '../../res/appurl/appurl.dart';

class ProductRepository {
  NetworkApiService apiService = NetworkApiService();
  Future<dynamic> getProductAll(String token) async {
    try {
      var repsonse = await apiService.getProduct(token, ApiUrl.getProduct);
      print(repsonse);
      return ProductModel.fromJson(repsonse);
    } catch (e) {
      rethrow;
    }
  }

}
