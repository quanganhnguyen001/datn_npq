import 'package:datn_npq/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/base_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    check();

    super.initState();
  }

  void check() async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    // if (checkAdmin != null) {
    //   Navigator.of(context)
    //       .pushNamedAndRemoveUntil(AdminScreen.routeName, (route) => false);
    // } else {
    context.read<AuthCubit>().checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(builder: (context) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/music_logo.png',
                height: 200,
              ),
            ),
          ],
        ),
      );
    });
  }
}
