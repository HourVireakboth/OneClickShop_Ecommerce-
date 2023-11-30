import 'package:oneclickshop/data/networkservice.dart';
import 'package:oneclickshop/model/showOrderRecord/showorder_record.dart';
import 'package:oneclickshop/res/appurl/appurl.dart';

class OrderRepository {
  NetworkApiService apiService = NetworkApiService();
  Future<dynamic> showOrderRecord(String token) async {
    try {
      var repsonse = await apiService.showOrderRecord(token,ApiUrl.showorder);
      print("responseOrder =$repsonse");
      return  ShowOrderRecordModel.fromJson(repsonse);
    } catch (e) {
      rethrow;
    }
  }

}
