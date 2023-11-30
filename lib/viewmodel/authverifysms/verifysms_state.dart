// ignore_for_file: must_be_immutable

part of 'verifysms_bloc.dart';

abstract class VerifysmsState extends Equatable {
  // const VerifysmsState();

  // @override
  // List<Object> get props => [];
}

class VerifysmsInitial extends VerifysmsState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class VerifysmsLoading extends VerifysmsState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class VerifysmsCompleted extends VerifysmsState {
  VerifyResponseModel? responseModel;
  VerifysmsCompleted({this.responseModel});
  @override
  List<VerifyResponseModel?> get props => [responseModel];

  
}

class VerifysmsError extends VerifysmsState {
  var error;
  VerifysmsError({this.error});
  @override
  List<Object?> get props => throw UnimplementedError();
}

class VerifysmsInvalid extends VerifysmsState {
  var error;
  VerifysmsInvalid({this.error});
  @override
  List<Object?> get props => throw UnimplementedError();
}
