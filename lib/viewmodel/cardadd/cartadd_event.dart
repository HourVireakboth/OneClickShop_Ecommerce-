// ignore_for_file: must_be_immutable

part of 'cartadd_bloc.dart';

abstract class CartaddEvent extends Equatable {
  const CartaddEvent();

  @override
  List<Object> get props => [];
}

class FetchCartAll extends CartaddEvent {
  var token;
  FetchCartAll({this.token});
}

class AddCart extends CartaddEvent {
  int? product_id;
  int? quantity;
  var color;
  var size;
  var image;
  String? token;
  AddCart(
      {this.product_id,
      this.quantity,
      this.color,
      this.size,
      this.image,
      this.token});
}

class UpdateCart extends CartaddEvent {
  int? product_id;
  int? quantity;
  var color;
  var size;
  int? cartId;
  String? token;

  UpdateCart(
      {this.product_id,
      this.quantity,
      this.color,
      this.size,
      this.cartId,
      this.token});
}
