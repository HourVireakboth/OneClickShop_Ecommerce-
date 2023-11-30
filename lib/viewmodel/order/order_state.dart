// ignore_for_file: must_be_immutable

part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderCompleted extends OrderState {
  ShowOrderRecordModel? showOrderRecordModel;
  OrderCompleted({this.showOrderRecordModel});
}

class OrderError extends OrderState {
  var error;
  OrderError({this.error});
}
