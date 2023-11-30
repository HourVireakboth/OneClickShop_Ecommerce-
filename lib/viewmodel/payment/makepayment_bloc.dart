import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oneclickshop/repository/payment/payment_repository.dart';

import '../../model/payment/payment.dart';

part 'makepayment_event.dart';
part 'makepayment_state.dart';

class MakepaymentBloc extends Bloc<MakepaymentEvent, MakepaymentState> {
  PaymentRepository paymentRepository = PaymentRepository();
  MakepaymentBloc() : super(MakepaymentInitial()) {
    on<MakePayments>((event, emit) async {
      var token = event.token;
      try {
        emit(MakepaymentLoading());
        var responseBody = await paymentRepository.makePayment(token);
        emit(MakepaymentCompleted(makePaymentModel: responseBody));
      } catch (error) {
        emit(MakepaymentError(error: error.toString()));
      }
    });
  }
}
