import 'package:admin_side/blocs/vehicle_bloc/vehicle_bloc.dart';
import 'package:admin_side/models/vehicle_model.dart';
import 'package:admin_side/repositories/components/alert_box.dart';
import 'package:admin_side/repositories/components/host_details_raw_widget.dart';
import 'package:admin_side/repositories/components/small_button_widget.dart';
import 'package:admin_side/repositories/components/sub_heading_widget.dart';
import 'package:admin_side/repositories/components/topbar_container.dart';
import 'package:admin_side/repositories/constants/colors.dart';
import 'package:admin_side/resources/api_url.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class VehicleDetailsScreen extends StatelessWidget {
  VehicleModel vehicleModel;
  bool? isVerifeid;
  VehicleDetailsScreen({super.key, required this.vehicleModel});

  @override
  Widget build(BuildContext context) {
    isVerifeid = vehicleModel.isVerified;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopbarContainer(),
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 15),
              child: SubHeadingWidget(title: 'Host Details'),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.66,
                height: 300,
                child: Card(
                  color: Colors.grey.shade200,
                  child: Row(
                    children: [
                      const SizedBox(width: 80),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HostDetailsRowWidget(
                                  title: 'Name :',
                                  details: vehicleModel.createdBy.name),
                              HostDetailsRowWidget(
                                  title: 'Email :',
                                  details: vehicleModel.createdBy.email),
                              HostDetailsRowWidget(
                                  title: 'User Verified :',
                                  details: vehicleModel.createdBy.isVerified
                                      .toString()),
                              HostDetailsRowWidget(
                                  title: 'Vehicle Verified :',
                                  details: vehicleModel.isVerified.toString()),
                              HostDetailsRowWidget(
                                  title: 'Phone :',
                                  details:
                                      vehicleModel.createdBy.phone.toString()),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Vehicle Document',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                child: Image.network(
                                  '${Url.baseUrl}/${vehicleModel.document}',
                                  width:
                                      MediaQuery.of(context).size.width * 0.27,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 15),
              child: SubHeadingWidget(title: 'Vehicle Details'),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: 440,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: Colors.black,
                    border: Border.all(width: 1)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(80),
                      child: Column(
                        children: [
                          HostDetailsRowWidget(
                            title: 'Vehicle Name :',
                            details: vehicleModel.name,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          HostDetailsRowWidget(
                            title: 'Vehicle Brand :',
                            details: vehicleModel.brand,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          HostDetailsRowWidget(
                            title: 'Vehicle Model :',
                            details: vehicleModel.model.toString(),
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          HostDetailsRowWidget(
                            title: 'Vehicle Fuel Type :',
                            details: vehicleModel.fuel,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          HostDetailsRowWidget(
                            title: 'Vehicle Transmission Type :',
                            details: vehicleModel.transmission,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          HostDetailsRowWidget(
                            title: 'Vehicle Location :',
                            details: vehicleModel.location,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          HostDetailsRowWidget(
                            title: 'Vehicle Price :',
                            details: "₹ ${vehicleModel.price.toString()}",
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 250),
                    Center(
                      child: SizedBox(
                        height: 200,
                        child: CarouselSlider(
                          items: vehicleModel.images
                              .map((e) => Image.network(
                                    '${Url.baseUrl}/$e',
                                    height: 150,
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    fit: BoxFit.cover,
                                  ))
                              .toList(),
                          options: CarouselOptions(
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            enableInfiniteScroll: true,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: BlocConsumer<VehicleBloc, VehicleState>(
                listener: (context, state) {
                  if (state is VehicleVerifyHostVehicleSuccessState) {
                    isVerifeid = true;
                    AlertBoxes().showSuccessDialog(context, 'Veified Success');
                  } else {
                    isVerifeid = false;
                  }
                },
                builder: (context, state) {
                  return Row(
                    children: [
                      isVerifeid == true
                          ? const Text(
                              'Verified',
                              style: TextStyle(color: Colors.green),
                            )
                          : SmallButtonWidget(
                              title: 'Verify',
                              color: AppColor.black,
                              onPress: () {
                                context.read<VehicleBloc>().add(
                                    VehicleVerifyHostVehicle(
                                        vehicleId: vehicleModel.id,
                                        hostId: vehicleModel.createdBy.id));
                              },
                            ),
                      const SizedBox(width: 10),
                      SmallButtonWidget(title: 'Reject', color: AppColor.red),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
