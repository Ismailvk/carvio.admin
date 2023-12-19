part of 'user_bloc.dart';

abstract class UserState {}

final class UserActionState extends UserState {}

final class UserInitial extends UserState {}

// fetch data
final class UserDataFetchDataSuccessState extends UserState {
  List<UserModel> unBlockeUsers;
  List<UserModel> blockedUser;
  UserDataFetchDataSuccessState(
      {required this.unBlockeUsers, required this.blockedUser});
}

final class UserDataFetchDataFailedState extends UserState {}

// Blocked

final class BlockButtonClickedLoadingState extends UserState {}

final class BlockButtonClickedSuccessState extends UserActionState {}

final class BlockButtonClickedFailedState extends UserState {}

// Unblocked

final class UnBlockButtonClickedLoadingState extends UserState {}

final class UnBlockButtonClickedSuccessState extends UserActionState {}

final class UnBlockButtonClickedFailedState extends UserState {}
