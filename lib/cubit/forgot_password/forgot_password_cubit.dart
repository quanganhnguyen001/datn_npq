import 'package:bloc/bloc.dart';
import 'package:datn_npq/screens/login_screen.dart';
import 'package:datn_npq/theme/app_style.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final emailController = TextEditingController();
  ForgotPasswordCubit() : super(const ForgotPasswordState());

  Future resetPassword({required BuildContext ctx}) async {
    EasyLoading.show();
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text)
          .then((value) {
        showDialog(
            context: ctx,
            builder: (context) {
              return AlertDialog(
                actions: [
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              (MaterialPageRoute(
                                  builder: (context) => LoginScreen())),
                              (route) => false);
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: Image.asset('assets/images/check.png'),
                content: Text(
                  'Go check your email and Login again',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.H4(color: Colors.red),
                ),
              );
            });
      });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: ctx,
          builder: (context) {
            Future.delayed((const Duration(seconds: 2)), () {
              Navigator.of(context).pop();
            });
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Image.asset('assets/images/alert_password.png'),
              content: Text(
                e.message.toString(),
                textAlign: TextAlign.center,
                style: AppTextStyle.H4(color: Colors.red),
              ),
            );
          });
      emailController.clear();
    }
    EasyLoading.dismiss();
  }
}
