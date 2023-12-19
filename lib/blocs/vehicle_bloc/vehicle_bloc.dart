import 'dart:async';
import 'dart:convert';
import 'package:admin_side/data/network/api_service.dart';
import 'package:admin_side/data/shared_preference/sharedprf.dart';
import 'package:admin_side/models/vehicle_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'vehicle_event.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  VehicleBloc() : super(VehicleInitial()) {
    on<VehicleFetchVehicleDataEvent>(vehicleFetchVehicleDataEvent);
    on<VehicleVerifyHostVehicle>(vehicleVerifyHostVehicle);
    // on<VehicleFetchHostDataEvent>(vehicleFetchHostData);
  }

  FutureOr<void> vehicleFetchVehicleDataEvent(
      VehicleFetchVehicleDataEvent event, Emitter<VehicleState> emit) async {
    final token = event.token;
    if (token == null) {
      emit(VehicleFetchFailState());
      return;
    }
    final response = await ApiService.instance.getAllVehicle(token);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List;
      // print(body);
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

      emit(VehicleFetchedDataState(vehicleModelList: listOfVehicle));
      // await ApiService.instance.getAllVehicle(token);
    }
  }

  FutureOr<void> vehicleVerifyHostVehicle(
      VehicleVerifyHostVehicle event, Emitter<VehicleState> emit) async {
    final token = Sharedpref.instance.getToken();
    if (token == null) {
      emit(VehicleVerifyHostVehicleFailedState());
      return;
    }
    try {
      final response = await ApiService.instance
          .verifyHostVehicle(event.vehicleId, event.hostId, token);
      final body = jsonDecode(response.body);
      if (body['message'] == 'Success') {
        emit(VehicleVerifyHostVehicleSuccessState());
      } else {
        emit(VehicleVerifyHostVehicleErrorState());
      }
    } catch (e) {
      print('Error $e');
    }
  }
}
