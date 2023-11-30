// ignore_for_file: must_be_immutable

part of 'makepayment_bloc.dart';

abstract class MakepaymentEvent extends Equatable {
  const MakepaymentEvent();

  @override
  List<Object> get props => [];
}

class MakePayments extends MakepaymentEvent {
  var token;
  MakePayments({this.token});
}
