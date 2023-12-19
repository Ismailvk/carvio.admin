part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginButtonEvent extends LoginEvent {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  LoginButtonEvent({required this.data});
}
