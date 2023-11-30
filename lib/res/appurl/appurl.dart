class ApiUrl {
  static var main = "http://127.0.0.1:8000/";
  static var authlogin = "${main}api/v1/login";
  static var authregister = "${main}api/v1/signup";
  static var authverfiysms = "${main}api/v1/verify_otp";
  static var getProduct = "${main}api/v1/products";
  static var getCart = "${main}api/v1/cart-items/";
  static var addCart = "${main}api/v1/cart-items/";
  static var getFavorite = "${main}api/v1/favorite_product/";
  static var getAddress = "${main}api/v1/user/addresses/create/";
  static var payment = "${main}api/v1/payments/";
  static var showorder = "${main}api/v1/invoice/";
  static var updateaddress = "${main}api/v1/users/addresses/";
  static var searchProduct = "${main}api/v1/products/search/?search=";
  static var userInformation = "${main}api/v1/user_info";
  static var updateuserInformation = "${main}api/v1/update_user_info";
  static var updateprofile = "${main}api/v1/user_profile";
}
