part of 'admin_bloc.dart';

@immutable
sealed class AdminState {}

final class AdminInitial extends AdminState {}

final class AdminFetchDataLoadingState extends AdminState {}

// ignore: must_be_immutable
final class AdminFetchedDataState extends AdminState {
  List<List<VehicleModel>> vehicleModelList = [];
  AdminFetchedDataState({required this.vehicleModelList});
}

final class AdminFetchFailState extends AdminState {}

final class AdminVerifyHostVehicleSuccessState extends AdminState {}

final class AdminVerifyHostVehicleFailedState extends AdminState {}

final class AdminVerifyHostVehicleErrorState extends AdminState {}
