part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginUser extends LoginEvent {
  var phonenumber;
  LoginUser({this.phonenumber});
}
