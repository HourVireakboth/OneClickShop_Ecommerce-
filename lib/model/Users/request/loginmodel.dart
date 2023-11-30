// ignore: file_names
class LoginModel {
  String? phonenumber;
  LoginModel({this.phonenumber});
  LoginModel.fromJson(Map<String, dynamic> json) {
    phonenumber = json['phone_number'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone_number'] = this.phonenumber;
    return data;
  }
}
