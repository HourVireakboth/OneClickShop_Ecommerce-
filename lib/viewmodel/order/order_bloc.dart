import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oneclickshop/model/showOrderRecord/showorder_record.dart';
import 'package:oneclickshop/repository/order/order.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderRepository orderRepository = OrderRepository();
  OrderBloc() : super(OrderInitial()) {
    on<FetchOrderRecords>((event, emit) async {
      var token = event.token;
      try {
        emit(OrderLoading());
        ShowOrderRecordModel responseBody = await orderRepository.showOrderRecord(token);
        print("test123");
        emit(OrderCompleted(showOrderRecordModel: responseBody));
        print("test1234");
      } catch (error) {
        emit(OrderError(error: error.toString()));
      }
    });
  }
}
