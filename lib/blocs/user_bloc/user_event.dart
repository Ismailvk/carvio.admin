part of 'user_bloc.dart';

abstract class UserEvent {}

final class UserDataFetchEvent extends UserEvent {}

final class BlocButtonClickedEvent extends UserEvent {
  final String id;
  final int index;
  BlocButtonClickedEvent({required this.id, required this.index});
}

final class UnblockedButtonClickedEvent extends UserEvent {
  final String id;
  final int index;
  UnblockedButtonClickedEvent({required this.id, required this.index});
}
