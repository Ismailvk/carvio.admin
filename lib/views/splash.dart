import 'package:admin_side/blocs/admin_bloc/admin_bloc.dart';
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
  void initState() {
    super.initState();
  }

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
      // ignore: use_build_context_synchronously
      context.read<AdminBloc>().add(AdminFetchVehicleDataEvent(token: token));
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }
}
