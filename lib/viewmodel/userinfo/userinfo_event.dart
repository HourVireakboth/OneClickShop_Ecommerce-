// ignore_for_file: must_be_immutable

part of 'userinfo_bloc.dart';

abstract class UserinfoEvent extends Equatable {
  const UserinfoEvent();

  @override
  List<Object> get props => [];
}

class GetUserInformation extends UserinfoEvent {
  var token;
  GetUserInformation({this.token});
}

class UpdateUserInformation extends UserinfoEvent {
  var token;
  var name;
  var email;
  UpdateUserInformation({this.token, this.name, this.email});
}

class UpdateUserProfile extends UserinfoEvent {
  var token;
  var pathfile;
  UpdateUserProfile({this.token, this.pathfile});
}
