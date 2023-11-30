// ignore_for_file: must_be_immutable

part of 'makepayment_bloc.dart';

abstract class MakepaymentState extends Equatable {
  const MakepaymentState();

  @override
  List<Object> get props => [];
}

class MakepaymentInitial extends MakepaymentState {}

class MakepaymentLoading extends MakepaymentState {}

class MakepaymentCompleted extends MakepaymentState {
  MakePaymentModel? makePaymentModel;
  MakepaymentCompleted({this.makePaymentModel});
}

class MakepaymentError extends MakepaymentState {
  var error;
  MakepaymentError({this.error});
}
