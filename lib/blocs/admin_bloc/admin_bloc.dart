import 'dart:async';
import 'dart:convert';
import 'package:admin_side/data/network/api_service.dart';
import 'package:admin_side/data/shared_preference/sharedprf.dart';
import 'package:admin_side/models/vehicle_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial()) {
    on<AdminFetchVehicleDataEvent>(adminFetchVehicleDataEvent);
    on<AdminVerifyHostVehicle>(adminVerifyHostVehicle);
  }

  FutureOr<void> adminFetchVehicleDataEvent(
      AdminFetchVehicleDataEvent event, Emitter<AdminState> emit) async {
    final token = event.token;
    if (token == null) {
      emit(AdminFetchFailState());
      return;
    }
    final response = await ApiService.instance.getAllVehicle(token);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List;
      final vehicleData = body.map((e) => VehicleModel.fromJson(e)).toList();
      List<List<VehicleModel>> listOfVehicle = [];
      List<VehicleModel> sublistOfVehicle = [];

      for (var i = 0; i < vehicleData.length; i++) {
        sublistOfVehicle.add(vehicleData[i]);

        if ((i + 1) % 3 == 0 || i == vehicleData.length - 1) {
          listOfVehicle.add(List.from(sublistOfVehicle));
          sublistOfVehicle.clear();
        }
      }

      emit(AdminFetchedDataState(vehicleModelList: listOfVehicle));
    }
  }

  FutureOr<void> adminVerifyHostVehicle(
      AdminVerifyHostVehicle event, Emitter<AdminState> emit) async {
    final token = Sharedpref.instance.getToken();
    if (token == null) {
      emit(AdminVerifyHostVehicleFailedState());
      return;
    }
    try {
      final response = await ApiService.instance
          .verifyHostVehicle(event.vehicleId, event.hostId, token);
      final body = jsonDecode(response.body);
      if (body['message'] == 'Success') {
        emit(AdminVerifyHostVehicleSuccessState());
      } else {
        emit(AdminVerifyHostVehicleErrorState());
      }
    } catch (e) {
      print('Error $e');
    }
  }
}
