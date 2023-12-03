import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../model/Users/response/registerAlreadyexist.dart';
import '../../repository/user/UserRepository.dart';

part 'authregister_event.dart';
part 'authregister_state.dart';

class AuthregisterBloc extends Bloc<AuthregisterEvent, AuthregisterState> {
  UserRepository userRepository = UserRepository();
  AuthregisterBloc() : super(AuthregisterInitial()) {
    on<UserRegister>((event, emit) async {
      var username = event.username;
      var email = event.email;
      var phonenumber = event.phonenumber;
      print(phonenumber);
      print(email);
      print(username);
      emit(RegisterLoading());
      try {
        var responseboby = await userRepository.AuthUserRegister(username, email, phonenumber);
        print("body:$responseboby");
        print("state code =${userRepository.apiService.RegisterCode} ");
        if (userRepository.apiService.RegisterCode == 200) {
          print("Token pass");
          emit(RegisterComplete());
        } else if (userRepository.apiService.RegisterCode == 400) {
          print("Already exist");
          emit(RegisterUnAuthorize(
              registertaken: responseboby,
              username: username,
              phonenumber: phonenumber,
              gmail: email));
        }
      } catch (error) {
        emit(RegisterError(error: error.toString()));
      }
    });
  }
}
