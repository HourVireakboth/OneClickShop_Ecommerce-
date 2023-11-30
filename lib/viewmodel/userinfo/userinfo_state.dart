// ignore_for_file: must_be_immutable

part of 'userinfo_bloc.dart';

abstract class UserinfoState extends Equatable {
  UserinfoState({this.userinformation});
  UserInformationModel? userinformation;
  @override
  List<Object> get props => [];
}

class UserinfoInitial extends UserinfoState {}

class UserinfoUnAuthorize extends UserinfoState {
  UserInformationTakenNameModel? nameready;
  UserinfoUnAuthorize({this.nameready});
}

class UserinfoLoading extends UserinfoState {}

class UserinfoCompleted extends UserinfoState {
  UserInformationModel? userinfor;
  UserinfoCompleted({this.userinfor}):super(userinformation: userinfor);
}

class UserinfoError extends UserinfoState {
  var error;
  UserinfoError({this.error});
}
