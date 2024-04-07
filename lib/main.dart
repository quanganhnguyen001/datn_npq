import 'package:datn_npq/cubit/login/login_cubit.dart';
import 'package:datn_npq/cubit/signup/signup_cubit.dart';

import 'package:datn_npq/screens/home_screen.dart';
import 'package:datn_npq/screens/login_screen.dart';
import 'package:datn_npq/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'auth/cubit/auth_cubit.dart';

import 'cubit/user/user_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(),
          ),
          BlocProvider<SignupCubit>(
            create: (context) => SignupCubit(),
          ),
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(),
          ),
          BlocProvider<UserCubit>(
            create: (context) => UserCubit()..loadUserData(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                ),
          ),
          home: SplashScreen(),
          builder: EasyLoading.init(),
        ));
  }
}
