import 'dart:async';
import 'dart:convert';
import 'package:admin_side/data/network/api_service.dart';
import 'package:admin_side/data/shared_preference/sharedprf.dart';
import 'package:admin_side/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserDataFetchEvent>(getUserData);
    on<BlocButtonClickedEvent>(blocButtonClickedEvent);
    on<UnblockedButtonClickedEvent>(unblockedButtonClickedEvent);
  }

  List<UserModel> unBlockedUsers = [];
  List<UserModel> blockedUsers = [];

  FutureOr<void> blocButtonClickedEvent(
      BlocButtonClickedEvent event, Emitter<UserState> emit) async {
    final token = Sharedpref.instance.getToken();
    if (token == null) {
      return null;
    }
    final response = await ApiService.instance.blockUser(event.id, token);
    try {
      if (response.statusCode == 200) {
        blockedUsers.add(unBlockedUsers[event.index]);
        unBlockedUsers.removeAt(event.index);
        emit(BlockButtonClickedSuccessState());
        emit(UserDataFetchDataSuccessState(
            blockedUser: blockedUsers, unBlockeUsers: unBlockedUsers));
      }
    } catch (e) {
      emit(BlockButtonClickedFailedState());
    }
  }

  FutureOr<void> unblockedButtonClickedEvent(
      UnblockedButtonClickedEvent event, Emitter<UserState> emit) async {
    final token = Sharedpref.instance.getToken();
    if (token == null) {
      return emit(UnBlockButtonClickedFailedState());
    }
    final response = await ApiService.instance.unBlockUser(event.id, token);
    try {
      if (response.statusCode == 200) {
        blockedUsers[event.index].isBlocked == false;
        unBlockedUsers.add(unBlockedUsers[event.index]);
        blockedUsers.removeAt(event.index);
        emit(UserDataFetchDataSuccessState(
            blockedUser: blockedUsers, unBlockeUsers: unBlockedUsers));
      }
    } catch (e) {
      emit(UnBlockButtonClickedFailedState());
    }
  }

  FutureOr<void> getUserData(
      UserDataFetchEvent event, Emitter<UserState> emit) async {
    final token = Sharedpref.instance.getToken();
    if (token == null) {
      return null;
    }
    final response = await ApiService.instance.getAllUsers(token);
    try {
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as List;
        final users = body.map((body) => UserModel.fromJson(body)).toList();
        unBlockedUsers =
            users.where((user) => user.isBlocked == false).toList();
        blockedUsers = users.where((user) => user.isBlocked == true).toList();
        emit(UserDataFetchDataSuccessState(
            unBlockeUsers: unBlockedUsers, blockedUser: blockedUsers));
      } else {}
    } catch (e) {}
  }
}
