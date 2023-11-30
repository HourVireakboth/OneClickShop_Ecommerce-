import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oneclickshop/model/Users/response/usertakenname.dart';
import 'package:oneclickshop/repository/user/UserRepository.dart';

import '../../model/Users/response/userinformationmodel.dart';

part 'userinfo_event.dart';
part 'userinfo_state.dart';

class UserinfoBloc extends Bloc<UserinfoEvent, UserinfoState> {
  UserRepository userRepository = UserRepository();
  UserinfoBloc() : super(UserinfoInitial()) {
    on<GetUserInformation>((event, emit) async {
      var token = event.token;
      try {
        emit(UserinfoLoading());
        var responseBody = await userRepository.userInformation(token);
        emit(UserinfoCompleted(userinfor: responseBody));
      } catch (error) {
        emit(UserinfoError(error: error.toString()));
      }
    });

    on<UpdateUserInformation>((event, emit) async {
      var token = event.token;
      var name = event.name;
      var email = event.email;
      UserInformationModel? userinfor = state.userinformation;
      print("name= ${userinfor!.username}");
      try {
        emit(UserinfoLoading());
        var responseBody =
            await userRepository.updateUserInformation(token, name, email);
        int? code = userRepository.statecode; 
        print("code : $code");
        if (code == 200) {
          print("200");
          emit(UserinfoCompleted(userinfor: responseBody));
        } else if (code == 400) {
          print("400");
          emit(UserinfoUnAuthorize(nameready: responseBody));
          emit(UserinfoCompleted(userinfor: userinfor));
        }
      } catch (error) {
        emit(UserinfoError(error: error.toString()));
      }
    });

    on<UpdateUserProfile>((event, emit) async {
      var token = event.token;
      var pathFile = event.pathfile;
      try {
        emit(UserinfoLoading());
        var responseBody = await userRepository.updateUserProfile(token, pathFile);
        emit(UserinfoCompleted(userinfor: responseBody));
      } catch (error) {
        emit(UserinfoError(error: error.toString()));
      }
    });
  }
}
