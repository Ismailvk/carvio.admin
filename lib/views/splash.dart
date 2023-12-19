// ignore_for_file: use_build_context_synchronously
import 'package:admin_side/blocs/host_bloc/host_bloc.dart';
import 'package:admin_side/blocs/user_bloc/user_bloc.dart';
import 'package:admin_side/blocs/vehicle_bloc/vehicle_bloc.dart';
import 'package:admin_side/data/shared_preference/sharedprf.dart';
import 'package:admin_side/views/home_screen.dart';
import 'package:admin_side/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    loginCheck(context);
    return const Scaffold(
      body: Center(
        child: Text('CARVIO'),
      ),
    );
  }

  loginCheck(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    final token = Sharedpref.instance.getToken();
    print('token is $token');
    if (token != null) {
      context
          .read<VehicleBloc>()
          .add(VehicleFetchVehicleDataEvent(token: token));
      context.read<HostBloc>().add(HostFetchDataEvent());
      context.read<UserBloc>().add(UserDataFetchEvent());
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }
}
