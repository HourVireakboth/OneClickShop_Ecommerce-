// ignore_for_file: must_be_immutable

part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class FetchOrderRecords extends OrderEvent {
  var token;
  FetchOrderRecords({this.token});
}
