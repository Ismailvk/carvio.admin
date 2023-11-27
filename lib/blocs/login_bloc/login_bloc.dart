import 'dart:async';
import 'dart:convert';
import 'package:admin_side/blocs/admin_bloc/admin_bloc.dart';
import 'package:admin_side/data/network/api_service.dart';
import 'package:admin_side/data/shared_preference/sharedprf.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonEvent>(loginAdmin);
  }

  FutureOr<void> loginAdmin(
      LoginButtonEvent event, Emitter<LoginState> emit) async {
    final data = event.data;

    try {
      final response = await ApiService.instance.login(data);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final token = body['token'];
        print('token is get $token');
        Sharedpref.instance.storeToken(token);
        emit(LoginAdminSuccessMessageState());
      } else if (response.statusCode == 404) {
        emit(LoginAdmimNotFoundState());
      } else if (response.statusCode == 401) {
        emit(LoginAdminWrongPasswordState());
      } else if (response.statusCode == 500) {
        emit(LoginAdminInternalErrorState());
      }
    } catch (e) {
      print('Error is $e');
    }
  }
}
