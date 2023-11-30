import 'package:oneclickshop/data/networkservice.dart';
import 'package:oneclickshop/model/Users/request/registermodel.dart';
import 'package:oneclickshop/model/Users/response/loginresponsemodel.dart';
import 'package:oneclickshop/model/Users/response/registerAlreadyexist.dart';
import 'package:oneclickshop/model/Users/response/registerresponsemodel.dart';
import 'package:oneclickshop/model/Users/response/userinformationmodel.dart';
import 'package:oneclickshop/model/Users/response/usertakenname.dart';
import 'package:oneclickshop/res/appurl/appurl.dart';

import '../../model/Users/response/verifycoderesponsemodel.dart';

class UserRepository {
  int? statecode;
  NetworkApiService apiService = NetworkApiService();
  Future<dynamic> AuthUserLogin(String phonenumber) async {
    try {
      var repsonse =
          await apiService.AuthUserLogin(phonenumber, ApiUrl.authlogin);
      print(repsonse);
      return LoginResponseModel.fromJson(repsonse);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> AuthUserVerifyCode(String otp) async {
    try {
      var repsonse =
          await apiService.AuthUserVerfiySMS(otp, ApiUrl.authverfiysms);
      print(repsonse);
      return VerifyResponseModel.fromJson(repsonse);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> AuthUserRegister(Username, Email, PhoneNumber) async {
    var userRegister = RegisterModel(
        username: Username, email: Email, phoneNumber: PhoneNumber);
    try {
      var repsonse = await apiService.AuthUserRegister(
          userRegister.toJson(), ApiUrl.authregister);
      print("statecode = ${apiService.RegisterCode}");
      if (apiService.RegisterCode == 200) {
        print(repsonse);
        return RegisterResponseModel.fromJson(repsonse);
      } else if (apiService.RegisterCode == 400) {
        print("repsonsebody = $repsonse");
        return RegisterResponseTaken.fromJson(repsonse);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> userInformation(String token) async {
    try {
      var repsonse =
          await apiService.userInformation(token, ApiUrl.userInformation);
      print(repsonse);
      return UserInformationModel.fromJson(repsonse);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateUserInformation(
      String token, String name, String email) async {
    try {
      var repsonse = await apiService.updateuserInformation(
          token, ApiUrl.updateuserInformation, name, email);
      print(repsonse);
      print("codestate = ${apiService.StatusCode} ");
      if (apiService.StatusCode == 200) {
        statecode = apiService.StatusCode;
        return UserInformationModel.fromJson(repsonse);
      } else if (apiService.StatusCode == 400) {
        statecode = apiService.StatusCode;
        return UserInformationTakenNameModel.fromJson(repsonse);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateUserProfile(String token, pathFile) async {
    try {
      var repsonse = await apiService.updateUserProfile(
          token, ApiUrl.updateprofile, pathFile);
      print("repsonseUpdateProflie = $repsonse");
      return UserInformationModel.fromJson(repsonse);
    } catch (e) {
      rethrow;
    }
  }
}
