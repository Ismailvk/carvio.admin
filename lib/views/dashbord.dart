import 'package:admin_side/repositories/components/host_details_raw_widget.dart';
import 'package:admin_side/repositories/components/sub_heading_widget.dart';
import 'package:admin_side/repositories/components/topbar_container.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                                  title: 'Name :', details: 'Ismail'),
                              HostDetailsRowWidget(
                                  title: 'Email :',
                                  details: 'ismail@gmail.com'),
                              HostDetailsRowWidget(
                                  title: 'IsVerified :', details: '56778'),
                              HostDetailsRowWidget(
                                  title: 'Phone :', details: '567786888'),
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
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.34,
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  child:
                                      Image.asset('assets/images/mustang.jpeg'),
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
                            details: 'Swift',
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          HostDetailsRowWidget(
                            title: 'Vehicle Brand :',
                            details: 'Suzuki',
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          HostDetailsRowWidget(
                            title: 'Vehicle Model :',
                            details: '2023',
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          HostDetailsRowWidget(
                            title: 'Vehicle Fuel Type :',
                            details: 'Petrol',
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          HostDetailsRowWidget(
                            title: 'Vehicle Transmission Type :',
                            details: 'Automatic',
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          HostDetailsRowWidget(
                            title: 'Vehicle Location :',
                            details: 'Kondotty',
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          HostDetailsRowWidget(
                            title: 'Vehicle Price :',
                            details: '2400',
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
                          items: [
                            Image.asset(
                              'assets/images/mustang.jpeg',
                              height: 150,
                              width: MediaQuery.of(context).size.width * 0.2,
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              'assets/images/mustang.jpeg',
                              height: 150,
                              width: MediaQuery.of(context).size.width * 0.2,
                              fit: BoxFit.cover,
                            )
                          ],
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
          ],
        ),
      ),
    );
  }
}
