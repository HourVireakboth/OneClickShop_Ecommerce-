import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oneclickshop/model/Products/product.dart';
import 'package:oneclickshop/repository/product/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

ProductRepository productRepository = ProductRepository();

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<FetchProducts>(
      (event, emit) => FetchingProduct(event, emit),
    );
  }
}

FetchingProduct(FetchProducts event, Emitter<ProductState> emit) async {
  var token = event.token;
  emit(ProductLoading());
  try {
    var repsonseboby = await productRepository.getProductAll(token);
    emit(ProductCompleted(productModel: repsonseboby));
  } catch (error) {
    emit(ProductError(error: error));
  }
}
