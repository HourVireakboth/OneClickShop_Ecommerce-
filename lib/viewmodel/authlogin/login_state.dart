// ignore_for_file: must_be_immutable

part of 'login_bloc.dart';

 abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginLoading extends LoginState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginCompleted extends LoginState {
  LoginResponseModel? message;
  LoginCompleted({this.message});
  @override
  List<Object?> get props => [
    message,
  ];
}

class LoginUnAuthorize extends LoginState {
  LoginUnAuthorize();
  @override
  List<Object?> get props => [];
}

class LoginError extends LoginState {
  var message;
  LoginError(this.message);
  @override
  List<Object?> get props => throw UnimplementedError();
}
