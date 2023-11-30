// ignore_for_file: must_be_immutable

part of 'cartadd_bloc.dart';


abstract class CartaddState extends Equatable {
  CartaddState({this.itemcart});
  List<CartItemModel>? itemcart = [];
  @override
  List<Object?> get props => [itemcart];

  void InsertToCart(CartItemModel item) {
    itemcart!.add(item);
  }

  void removeFromCart(CartItem item) {
    itemcart!.removeWhere((element) => element == item);
  }
}

class CartaddInitial extends CartaddState {
  CartaddInitial() : super(itemcart: []);
}

class CartLoading extends CartaddState {}

class CartCompleted extends CartaddState {
  List<CartItemModel>? cartItemModel;
  
  CartCompleted({this.cartItemModel}):super(itemcart: cartItemModel);
}

class CartError extends CartaddState {
  var error;
  CartError({this.error});
}
