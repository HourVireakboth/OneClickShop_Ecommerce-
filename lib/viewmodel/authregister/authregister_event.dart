part of 'authregister_bloc.dart';

abstract class AuthregisterEvent extends Equatable {
  const AuthregisterEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class UserRegister extends AuthregisterEvent {
  var username;
  var email;
  var phonenumber;

  UserRegister({this.username, this.email, this.phonenumber});
}
