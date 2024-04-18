import 'dart:io';

import 'package:datn_npq/auth/model/user_model.dart';
import 'package:datn_npq/theme/color_paletes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../cubit/update_profile/update_profile_cubit.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key, required this.user});
  final UserModel user;

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  void initState() {
    context.read<UpdateProfileCubit>().nameController.text =
        widget.user.name ?? '';
    context.read<UpdateProfileCubit>().phoneController.text =
        widget.user.phone ?? '';

    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade800.withOpacity(0.8),
              Colors.deepPurple.shade200.withOpacity(0.8),
            ],
          ),
        ),
        child: Center(
          child: Form(
            key: formKey,
            child: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
              builder: (context, state) {
                return Column(
                  children: [
                    InkWell(
                        onTap: () {
                          context.read<UpdateProfileCubit>().selectImage();
                        },
                        child: state.imageBytes == null
                            ? Center(
                                child: Container(
                                    height: 155,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 3,
                                            color:
                                                ColorPalettes.secondaryColor)),
                                    child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            widget.user.imageUrl ?? ''))),
                              )
                            : Container(
                                height: 155,
                                width: 140,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 3,
                                        color: ColorPalettes.secondaryColor)),
                                child: CircleAvatar(
                                  backgroundImage: MemoryImage(
                                      state.imageBytes ?? Uint8List(0)),
                                ))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Text(
                            'Tên của bạn',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 400),
                            child: TextFormField(
                              controller: context
                                  .read<UpdateProfileCubit>()
                                  .nameController,
                              style: TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tên không hợp lệ';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(190, 186, 179, 1),
                                    )),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(190, 186, 179, 1),
                                    )),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(190, 186, 179, 1),
                                    )),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(190, 186, 179, 1),
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(190, 186, 179, 1),
                                    )),
                                contentPadding: EdgeInsets.only(left: 16),
                                border: InputBorder.none,
                                hintText: 'Tên tài khoản',
                              ),
                            ),
                          ),
                          Text(
                            'SĐT của bạn',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 400),
                            child: TextFormField(
                              controller: context
                                  .read<UpdateProfileCubit>()
                                  .phoneController,
                              style: TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'SĐT không hợp lệ';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(190, 186, 179, 1),
                                    )),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(190, 186, 179, 1),
                                    )),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(190, 186, 179, 1),
                                    )),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(190, 186, 179, 1),
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(190, 186, 179, 1),
                                    )),
                                contentPadding: EdgeInsets.only(left: 16),
                                border: InputBorder.none,
                                hintText: 'Số điện thoại',
                              ),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  if (state.imageBytes != null) {
                                    context
                                        .read<UpdateProfileCubit>()
                                        .updateProfileWithImage(
                                            context, state.imageBytes);
                                  } else {
                                    context
                                        .read<UpdateProfileCubit>()
                                        .updateProfile(context);
                                  }
                                }
                              },
                              child: Text('Xác nhận'))
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
