import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oneclickshop/model/Token/token.dart';
import 'package:oneclickshop/model/Users/response/verifycoderesponsemodel.dart';
import 'package:oneclickshop/repository/user/UserRepository.dart';

part 'verifysms_event.dart';
part 'verifysms_state.dart';

class VerifysmsBloc extends Bloc<VerifysmsEvent, VerifysmsState> {
  UserRepository user = UserRepository();
  VerifysmsBloc() : super(VerifysmsInitial()) {
    on<VerifySMSUser>((event, emit) async {
      // TODO: implement event handler
      var otp = event.verifycode;
      print("otp:${event.verifycode}");
      print('Event on Verifysms code');
      emit(VerifysmsLoading());
      try {
        VerifyResponseModel responseboby = await user.AuthUserVerifyCode(otp);
        print("body:${responseboby.token}");
        if (responseboby.token != null) {
          emit(VerifysmsCompleted(responseModel: responseboby));
          TokenModel().tokenls.add(responseboby.token.toString());
        } else if (responseboby.error == "Invalid OTP.") {
          print(responseboby.error);
          emit(VerifysmsInvalid(error: responseboby.error));
        }
      } catch (error) {
        print(error.toString());
        emit(VerifysmsError(error: error.toString()));
      }
    });
  }
}
