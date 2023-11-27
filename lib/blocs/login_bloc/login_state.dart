part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

abstract class LoginActionState extends LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {}

final class LoginErrorState extends LoginState {}

// Action State

final class LoginAdminSuccessMessageState extends LoginActionState {}

final class LoginAdmimNotFoundState extends LoginActionState {}

final class LoginAdminWrongPasswordState extends LoginActionState {}

final class LoginAdminInternalErrorState extends LoginActionState {}
