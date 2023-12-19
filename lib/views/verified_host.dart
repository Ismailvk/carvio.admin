import 'package:admin_side/blocs/host_bloc/host_bloc.dart';
import 'package:admin_side/repositories/constants/colors.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class VerifiedHostScreen extends StatelessWidget {
  const VerifiedHostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HostBloc, HostState>(
        listener: (context, state) {
          if (state is HostApprovelFailedState) {
            AnimatedSnackBar.material(
              'Something Went Wrong',
              type: AnimatedSnackBarType.error,
            ).show(context);
          }
        },
        builder: (context, state) {
          if (state is HostFetchAllHostsSuccessState) {
            if (state.hostVerifiedData.isEmpty) {
              return Center(
                  child: Lottie.asset('assets/images/manLottie.json'));
            }
            return ListView.builder(
              itemCount: state.hostVerifiedData.length,
              itemBuilder: (context, index) {
                final createdBy = state.hostVerifiedData[index];
                return createdBy.isVerified == true
                    ? SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Card(
                            color: AppColor.lightGrey,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: ListTile(
                                mouseCursor: MouseCursor.uncontrolled,
                                leading: const CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      'https://cdn.pixabay.com/photo/2017/06/09/23/22/avatar-2388584_1280.png'),
                                ),
                                titleAlignment: ListTileTitleAlignment.center,
                                title: Text(createdBy.name),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_sharp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const Center(
                        child: Text('No pending hosts found'),
                      );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
