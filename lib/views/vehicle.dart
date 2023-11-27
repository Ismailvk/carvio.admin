import 'package:admin_side/blocs/admin_bloc/admin_bloc.dart';
import 'package:admin_side/models/vehicle_model.dart';
import 'package:admin_side/repositories/components/button_widget.dart';
import 'package:admin_side/repositories/components/car_row_widget.dart';
import 'package:admin_side/repositories/components/heading_widget.dart';
import 'package:admin_side/repositories/components/topbar_container.dart';
import 'package:admin_side/resources/api_url.dart';
import 'package:admin_side/views/vehicle_details_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TopbarContainer(),
          const HeadingWidget(),
          Expanded(
            child: BlocBuilder<AdminBloc, AdminState>(
              builder: (context, state) {
                if (state is AdminFetchedDataState) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: state.vehicleModelList[currentPage].length,
                    itemBuilder: (BuildContext context, int index) {
                      VehicleModel vehicle =
                          state.vehicleModelList[currentPage][index];
                      return Column(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.9,
                              width: MediaQuery.of(context).size.width * 0.27,
                              child: Card(
                                color: const Color.fromARGB(255, 227, 227, 227),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: CarouselSlider(
                                          items: vehicle.images
                                              .map((e) => Image.network(
                                                    '${Url.baseUrl}/$e',
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.28,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
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
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('${vehicle.brand} ${vehicle.name}',
                                            style:
                                                const TextStyle(fontSize: 18)),
                                        const SizedBox(width: 10),
                                        vehicle.isVerified == true
                                            ? const Icon(
                                                Icons.verified,
                                                color: Colors.blue,
                                                size: 18,
                                              )
                                            : const SizedBox()
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '₹ ${vehicle.price}',
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 18),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CarRowWidget(
                                            image:
                                                'assets/images/petrol-pump.svg',
                                            title: vehicle.fuel),
                                        CarRowWidget(
                                            image: 'assets/images/car.svg',
                                            title: vehicle.model.toString()),
                                        CarRowWidget(
                                            image:
                                                'assets/images/settings-bold.svg',
                                            title: vehicle.transmission)
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CarRowWidget(
                                            image:
                                                'assets/images/location-filled.svg',
                                            title: vehicle.location),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    InkWell(
                                        onTap: () => Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VehicleDetailsScreen(
                                                      vehicleModel: vehicle,
                                                    ))),
                                        child:
                                            ButtonWidget(title: 'View Details'))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          BlocBuilder<AdminBloc, AdminState>(
            builder: (context, state) {
              if (state is AdminFetchedDataState) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 300),
                  child: NumberPaginator(
                    numberPages: state.vehicleModelList.length,
                    onPageChange: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                  ),
                );
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 50)
        ],
      ),
    );
  }
}
