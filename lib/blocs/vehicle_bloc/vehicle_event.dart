part of 'vehicle_bloc.dart';

abstract class VehicleEvent {}

class VehicleFetchVehicleDataEvent extends VehicleEvent {
  final String? token;
  VehicleFetchVehicleDataEvent({required this.token});
}

class VehicleVerifyHostVehicle extends VehicleEvent {
  final String vehicleId;
  final String hostId;

  VehicleVerifyHostVehicle({required this.vehicleId, required this.hostId});
}
