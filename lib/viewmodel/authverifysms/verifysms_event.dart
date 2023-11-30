part of 'verifysms_bloc.dart';

abstract class VerifysmsEvent {
}

// ignore: must_be_immutable
class VerifySMSUser extends VerifysmsEvent {
  var verifycode;
  VerifySMSUser({this.verifycode});
}
