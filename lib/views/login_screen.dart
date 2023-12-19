import 'package:admin_side/blocs/host_bloc/host_bloc.dart';
import 'package:admin_side/blocs/login_bloc/login_bloc.dart';
import 'package:admin_side/blocs/user_bloc/user_bloc.dart';
import 'package:admin_side/blocs/vehicle_bloc/vehicle_bloc.dart';
import 'package:admin_side/data/shared_preference/sharedprf.dart';
import 'package:admin_side/repositories/components/button_widget.dart';
import 'package:admin_side/repositories/components/custom_textfield.dart';
import 'package:admin_side/repositories/constants/colors.dart';
import 'package:admin_side/utils/validation.dart';
import 'package:admin_side/views/home_screen.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listenWhen: (previous, current) => current is LoginActionState,
        listener: (context, state) {
          if (state is LoginAdminSuccessMessageState) {
            final token = Sharedpref.instance.getToken();
            context
                .read<VehicleBloc>()
                .add(VehicleFetchVehicleDataEvent(token: token));
            context.read<HostBloc>().add(HostFetchDataEvent());
            context.read<UserBloc>().add(UserDataFetchEvent());
            AnimatedSnackBar.material(
              'Login Success',
              type: AnimatedSnackBarType.success,
            ).show(context);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false);
          } else if (state is LoginAdmimNotFoundState) {
            AnimatedSnackBar.material(
              'Admin Not Found',
              type: AnimatedSnackBarType.error,
            ).show(context);
          } else if (state is LoginAdminWrongPasswordState) {
            AnimatedSnackBar.material(
              'Wrong Password',
              type: AnimatedSnackBarType.error,
            ).show(context);
          }
        },
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover)),
            ),
            Container(
              padding: const EdgeInsets.only(left: 550, top: 100),
              alignment: Alignment.topCenter,
              height: 900,
              width: 1000,
              child: Image.asset('assets/images/rectangle.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CARVIO',
                    style: GoogleFonts.orbitron(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.white,
                            fontSize: 35)),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    "Welcome Back !!! \nLet's start your journey",
                    style: TextStyle(color: AppColor.white, fontSize: 25),
                  )
                ],
              ),
            ),
            Positioned(
              left: 600,
              top: 140,
              child: Form(
                key: loginKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Log in your Account',
                      style: GoogleFonts.orbitron(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.white,
                              fontSize: 25)),
                    ),
                    const SizedBox(height: 80),
                    MyTextField(
                      controller: emailController,
                      isSufix: false,
                      hintText: 'Email',
                      obscureText: false,
                      validator: (value) => Validations.emailValidation(value!),
                    ),
                    MyTextField(
                      controller: passwordController,
                      isSufix: false,
                      hintText: 'Password',
                      obscureText: false,
                      validator: (value) =>
                          Validations.passwordValidation(value!),
                    ),
                    ButtonWidget(
                      title: 'Sign in',
                      onPress: () => validateButton(context),
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

  validateButton(BuildContext context) {
    if (loginKey.currentState!.validate()) {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();
      final loginData = {
        "email": email,
        "password": password,
      };
      context.read<LoginBloc>().add(LoginButtonEvent(data: loginData));
    }
  }
}
