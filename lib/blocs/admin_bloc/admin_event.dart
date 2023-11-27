part of 'admin_bloc.dart';

@immutable
abstract class AdminEvent {}

// ignore: must_be_immutable
class AdminFetchVehicleDataEvent extends AdminEvent {
  String? token;
  AdminFetchVehicleDataEvent({required this.token});
}

class AdminVerifyHostVehicle extends AdminEvent {
  final String vehicleId;
  final String hostId;

  AdminVerifyHostVehicle({required this.vehicleId, required this.hostId});
}
