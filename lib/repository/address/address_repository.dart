import 'package:oneclickshop/model/address/address.dart';
import 'package:oneclickshop/res/appurl/appurl.dart';

import '../../data/networkservice.dart';

class AddressRepository {
  NetworkApiService apiService = NetworkApiService();
  Future<dynamic> getAddressAll(String token) async {
    try {
      var repsonse = await apiService.getAllAddress(token, ApiUrl.getAddress);
      print("response=$repsonse");
      return repsonse;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> addAddress(
      String token, String contactname, String street, String province) async {
    try {
      var repsonse = await apiService.addAddress(
          token, ApiUrl.getAddress, contactname, street, province);
      print("response=$repsonse");
      return AddressModel.fromJson(repsonse);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateAddress(String token, String contactname, String street,
      String province, String addressId) async {
    try {
      var repsonse = await apiService.updataAddress(
          token, "${ApiUrl.updateaddress}$addressId", contactname, street, province);
      print("response=$repsonse");
      return AddressModel.fromJson(repsonse);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteAddress(String token, String addressId) async {
    try {
      var repsonse = await apiService.deleteAddress(
          token, "${ApiUrl.updateaddress}$addressId");
      print("response=$repsonse");
      return repsonse;
    } catch (e) {
      rethrow;
    }
  }
}
