part of 'vehicle_bloc.dart';

sealed class VehicleState {}

final class VehicleInitial extends VehicleState {}

final class VehicleFetchDataLoadingState extends VehicleState {}

// ignore: must_be_immutable
final class VehicleFetchedDataState extends VehicleState {
  List<List<VehicleModel>> vehicleModelList = [];
  VehicleFetchedDataState({required this.vehicleModelList});
}

final class VehicleFetchFailState extends VehicleState {}

final class VehicleVerifyHostVehicleSuccessState extends VehicleState {}

final class VehicleVerifyHostVehicleFailedState extends VehicleState {}

final class VehicleVerifyHostVehicleErrorState extends VehicleState {}

final class VehicleFetchHostDataState extends VehicleState {}

final class VehicleFetchHostDataSuccessState extends VehicleState {
  List<CreatedBy> hostData = [];
  VehicleFetchHostDataSuccessState({required this.hostData});
}

final class VehicleFetchHostDataFailedState extends VehicleState {}
