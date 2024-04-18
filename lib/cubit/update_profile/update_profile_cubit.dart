import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn_npq/screens/home_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../../auth/model/user_model.dart';
import '../../theme/app_style.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(const UpdateProfileState(imageBytes: null));
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  Future<void> selectImage() async {
    FilePickerResult? file = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
    );

    if (file != null) {
      emit(state.copyWith(file.files.first.bytes));
    }
  }

  Future<void> updateProfileWithImage(BuildContext ctx, Uint8List? file) async {
    EasyLoading.show();
    try {
      html.Blob blob = html.Blob([state.imageBytes]);
      FirebaseStorage storage = FirebaseStorage.instance;
      final ref = FirebaseStorage.instance
          .ref()
          .child('userImage')
          .child('/${FirebaseAuth.instance.currentUser!.uid}');
      if (file != null) {
        await ref.putBlob(blob);
      }

      String imageUrl = await ref.getDownloadURL();
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(UserModel(
            name: nameController.text,
            phone: phoneController.text,
            imageUrl: imageUrl,
          ).toMap());
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
    }
    EasyLoading.dismiss();
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }

  Future<void> updateProfile(BuildContext ctx) async {
    EasyLoading.show();
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(UserModel(
            name: nameController.text,
            phone: phoneController.text,
          ).toMap());
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
    }
    EasyLoading.dismiss();
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }
}
