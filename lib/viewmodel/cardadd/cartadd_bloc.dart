import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oneclickshop/repository/cart/cart_repository.dart';

import '../../model/cart/cartmodel.dart';

part 'cartadd_event.dart';
part 'cartadd_state.dart';

class CartaddBloc extends Bloc<CartaddEvent, CartaddState> {
  CartRepository cart = CartRepository();
  CartaddBloc() : super(CartaddInitial()) {
    on<FetchCartAll>((event, emit) async {
      var token = event.token;
      try {
        emit(CartLoading());
        List<CartItemModel> responsebody = await cart.getCartAll(token);
        // List<CartItemModel> cartlist = [];
        // for (var temp in responsebody) {
        //   cartlist.add(temp);
        // }
        print("list = ${responsebody[0].product!.name}");
        emit(CartCompleted(cartItemModel: responsebody));
      } catch (error) {
        print(error.toString());
        emit(CartError(error: error.toString()));
      }
    });

    on<AddCart>((event, emit) async {
      int? productid = event.product_id;
      int? qty = event.quantity;
      var color = event.color;
      var size = event.size;
      String? image = event.image;
      String? token = event.token;
      print('pID:$productid');
      print("qty:$qty ");
      print('color:$color');
      print("size:$size ");
      print("image:$image ");
      try {
        List<CartItemModel>? curr = state.itemcart ?? [];
        var isupdate = false;
        int index = -1;
        state.itemcart?.forEach((element) {
          if (element.product?.id == productid &&
              element.color == color &&
              element.size == size) {
            isupdate = true;
            print(element.quantity);
            index = state.itemcart!.indexOf(element);
          }
        });
        print(index);
        print(isupdate);
        if (isupdate == true) {
          print("Already existed");
          CartItemModel cartitem = state.itemcart![index];
          cartitem.quantity = cartitem.quantity! + 1;
          
          curr.removeAt(index);
          curr.insert(index, cartitem);
          print("qty:${curr[index].quantity}");
          await cart.addCart(productid!, qty!, color!, size!, image!, token!);
        } else {
          print("Does not exist");
          await cart.addCart(productid!, qty!, color!, size!, image!, token!);
        }
        emit(CartLoading());
        // print("countlist ${cartlist?.length}");
        emit(CartCompleted(cartItemModel: curr));
      } catch (error) {
        print(error.toString());
        emit(CartError(error: error.toString()));
      }
    });

    on<UpdateCart>((event, emit) async {
      int? productid = event.product_id;
      int? qty = event.quantity;
      var color = event.color;
      var size = event.size;
      int? cartID = event.cartId;
      String? token = event.token;
      print('pID:$productid');
      print("qty:$qty ");
      print('color:$color');
      print("size:$size ");

      try {
        List<CartItemModel>? curr = state.itemcart;
        var isupdate = false;
        int index = -1;
        state.itemcart?.forEach((element) {
          if (element.product?.id == productid &&
              element.color == color &&
              element.size == size) {
            isupdate = true;
            print(element.quantity);
            index = state.itemcart!.indexOf(element);
          }
        });
        print(index);
        print(isupdate);
        if (isupdate == true) {
          CartItemModel cartitem = state.itemcart![index];
          cartitem.quantity = cartitem.quantity! - 1;
          qty = cartitem.quantity!;
          print("qty:${curr?[index].quantity}");
          if (qty == 0) {
            print("CartDelete");
            curr?.removeAt(index);
            await cart.deleteCart(cartID!, token!);
          } else {
            print("CartUpdate");
            curr?.removeAt(index);
            curr?.insert(index, cartitem);
            await cart.updateCart(
                productid!, qty, color!, size!, cartID!, token!);
          }
        }
        emit(CartLoading());
        // print("countlist ${cartlist?.length}");
        emit(CartCompleted(cartItemModel: curr));
      } catch (error) {
        print(error.toString());
        emit(CartError(error: error.toString()));
      }
    });
  }
}
