import 'package:admin_side/blocs/user_bloc/user_bloc.dart';
import 'package:admin_side/repositories/components/small_button_widget.dart';
import 'package:admin_side/repositories/constants/colors.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class BlockedUsersScreen extends StatelessWidget {
  const BlockedUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        body: BlocConsumer<UserBloc, UserState>(
          buildWhen: (previous, current) => current is! UserActionState,
          listenWhen: (previous, current) => current is UserActionState,
          listener: (context, state) {
            if (state is UnBlockButtonClickedSuccessState) {
              AnimatedSnackBar.material(
                'User UnBlocked success',
                desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
                type: AnimatedSnackBarType.success,
              ).show(context);
            }
          },
          builder: (context, state) {
            if (state is UserDataFetchDataSuccessState) {
              if (state.blockedUser.isEmpty) {
                return Center(
                    child: Lottie.asset('assets/images/noDataFound.json'));
              }
              return ListView.builder(
                itemCount: state.blockedUser.length,
                itemBuilder: (context, index) {
                  final createdBy = state.blockedUser[index];
                  return state.blockedUser.isNotEmpty
                      ? SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Card(
                              color: AppColor.lightGrey,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: ListTile(
                                    mouseCursor: MouseCursor.uncontrolled,
                                    leading: const CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                          'https://cdn.pixabay.com/photo/2017/06/09/23/22/avatar-2388584_1280.png'),
                                    ),
                                    titleAlignment:
                                        ListTileTitleAlignment.center,
                                    title: Row(
                                      children: [
                                        Text(createdBy.name),
                                        const SizedBox(width: 80),
                                        Text(createdBy.email),
                                        const SizedBox(width: 80),
                                        Text(createdBy.phone.toString()),
                                      ],
                                    ),
                                    trailing: SmallButtonWidget(
                                        onPress: () {
                                          context.read<UserBloc>().add(
                                              UnblockedButtonClickedEvent(
                                                  id: createdBy.id,
                                                  index: index));
                                        },
                                        title: 'UnBlock',
                                        color: AppColor.green)),
                              ),
                            ),
                          ),
                        )
                      : const Center(
                          child: Text("You haven't blocked user"),
                        );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}
