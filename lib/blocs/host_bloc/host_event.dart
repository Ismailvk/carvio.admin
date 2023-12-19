part of 'host_bloc.dart';

abstract class HostEvent {}

class HostFetchDataEvent extends HostEvent {}

class HostAprovedClicked extends HostEvent {
  final String id;
  final int index;
  HostAprovedClicked({required this.index, required this.id});
}
