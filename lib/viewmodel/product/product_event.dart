// ignore_for_file: must_be_immutable

part of 'product_bloc.dart';
abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {
  var token;
  FetchProducts({this.token});
}