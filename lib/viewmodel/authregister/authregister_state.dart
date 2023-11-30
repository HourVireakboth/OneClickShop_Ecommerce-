part of 'authregister_bloc.dart';

abstract class AuthregisterState extends Equatable {}

class AuthregisterInitial extends AuthregisterState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class RegisterUnAuthorize extends AuthregisterState {
  RegisterResponseTaken? registertaken;
  String? username;
  String? gmail;
  String? phonenumber;
  RegisterUnAuthorize({
    this.registertaken,
    this.username,
    this.gmail,
    this.phonenumber
  });
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class RegisterError extends AuthregisterState {
  var error;
  RegisterError({this.error});
  @override
  List<Object?> get props => throw UnimplementedError();
}

class RegisterLoading extends AuthregisterState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class RegisterComplete extends AuthregisterState {
  @override
  List<Object?> get props => throw UnimplementedError();
}
