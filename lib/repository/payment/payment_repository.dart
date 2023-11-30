import 'package:oneclickshop/model/payment/payment.dart';
import 'package:oneclickshop/res/appurl/appurl.dart';

import '../../data/networkservice.dart';

class PaymentRepository{
  NetworkApiService apiService = NetworkApiService();
  Future<dynamic> makePayment(String token) async {
    try {
      var repsonse = await apiService.makePayment(token,ApiUrl.payment);
      print("response=$repsonse");
      return MakePaymentModel.fromJson(repsonse);
    } catch (e) {
      rethrow;
    }
  }
}