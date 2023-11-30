// ignore_for_file: must_be_immutable

part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ProductLoading extends ProductState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ProductCompleted extends ProductState {
  ProductModel? productModel;

  ProductCompleted({this.productModel});
  @override
  List<Object?> get props => [productModel];
}

class ProductError extends ProductState {
  var error;
  ProductError({this.error});
  @override
  List<Object?> get props => [error];
}
