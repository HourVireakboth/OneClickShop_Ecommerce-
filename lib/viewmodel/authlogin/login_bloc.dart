import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oneclickshop/model/Users/response/loginresponsemodel.dart';
import 'package:oneclickshop/repository/user/UserRepository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository = UserRepository();
  LoginBloc() : super(LoginInitial()) {
    on<LoginUser>((event, emit) async {
      var phone = event.phonenumber;
      print("PhoneNumber: $phone");
      emit(LoginLoading());
      try {
        LoginResponseModel responsebody =
            await userRepository.AuthUserLogin(phone);
        print("error:${responsebody.error}");
        print("messsage:${responsebody.message}");
        if (responsebody.error == "User does not exist.") {
          emit(LoginUnAuthorize());
        } else if (responsebody.message ==
            "Please verify the 6-digit code sent to your phone number.") {
          emit(LoginCompleted(message: responsebody));
          print("completed");
        }
      } catch (error) {
        emit(LoginError(error));
      }
    });
  }
}
