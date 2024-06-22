import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:datn_npq/cubit/upload_song/upload_song_cubit.dart';
import 'package:datn_npq/models/song_model.dart';
import 'package:datn_npq/theme/app_style.dart';
import 'package:datn_npq/theme/color_paletes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../models/playlist_model.dart';

class UploadSongWidget extends StatefulWidget {
  const UploadSongWidget({super.key});

  @override
  State<UploadSongWidget> createState() => _UploadSongWidgetState();
}

class _UploadSongWidgetState extends State<UploadSongWidget> {
  bool isTrending = false;
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  Uint8List? imageSong;
  String songPicked = '';
  String name = '';
  Uint8List? audioFile;
  String? dropDownValue;
  String? docId;
  List<Song> newSong = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: BlocBuilder<UploadSongCubit, UploadSongState>(
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                    onTap: () async {
                      FilePickerResult? file = await FilePicker.platform.pickFiles(
                        type: FileType.image,
                        allowCompression: true,
                      );

                      if (file != null) {
                        setState(() {
                          imageSong = file.files.first.bytes;
                          name = file.files.first.name;
                        });
                      }
                    },
                    child: imageSong == null
                        ? Center(
                            child: Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(color: Colors.grey, border: Border.all(width: 3, color: ColorPalettes.secondaryColor)),
                            ),
                          )
                        : Center(
                            child: Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(border: Border.all(width: 3, color: ColorPalettes.secondaryColor)),
                                child: Image.memory(imageSong ?? Uint8List(0))),
                          )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 400),
                  child: TextFormField(
                    controller: titleController,
                    style: TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tên bai hat';
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
                      hintText: 'Nhập tên bai hat của bạn',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 400),
                  child: TextFormField(
                    controller: descriptionController,
                    style: TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mo ta';
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
                      hintText: 'Nhập mo ta của bạn',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                          type: FileType.audio,
                        );

                        if (result != null) {
                          setState(() {
                            audioFile = result.files.single.bytes;
                            songPicked = result.files.single.name;
                          });
                        }
                      },
                      child: Text(
                        songPicked == '' ? 'Chon bai hat' : songPicked,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        CupertinoSwitch(
                            value: isTrending,
                            onChanged: (value) {
                              setState(() {
                                isTrending = value;
                              });
                            }),
                        Text(
                          isTrending == false ? 'Khong Thinh hanh' : 'Thinh hanh',
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButton(
                  focusColor: Colors.transparent,
                  hint: Text('Chon playlist'),
                  style: TextStyle(color: Colors.red),
                  value: dropDownValue,
                  items: state.playList.map((e) {
                    return DropdownMenuItem(
                      child: Text(e.title ?? ''),
                      value: e.title,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      dropDownValue = value.toString();
                    });
                  },
                ),
                GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      EasyLoading.show();
                      try {
                        html.Blob blob = html.Blob([imageSong]);
                        final ref = FirebaseStorage.instance.ref().child('songImage').child(name);
                        final refAudio = FirebaseStorage.instance.ref().child('audio').child(songPicked);
                        if (imageSong != null) {
                          await ref.putBlob(blob);
                        }
                        if (audioFile != null) {
                          await refAudio.putData(audioFile!);
                        }
                        String audioUrl = await refAudio.getDownloadURL();
                        String imageUrl = await ref.getDownloadURL();
                        for (var i in state.playList) {
                          if (i.title == dropDownValue) {
                            i.songs?.add(Song(
                              title: titleController.text,
                              description: descriptionController.text,
                              url: audioUrl,
                              coverUrl: imageUrl,
                              dropDownValue: dropDownValue,
                            ));
                            docId = i.playlistId;
                            newSong = i.songs ?? [];
                          }
                        }
                        FirebaseFirestore.instance.collection('playlist').doc(docId).update(Playlist(songs: newSong).toMap());
                        FirebaseFirestore.instance.collection('song').doc().set(Song(
                                title: titleController.text,
                                coverUrl: imageUrl,
                                url: audioUrl,
                                isTrending: isTrending,
                                dropDownValue: dropDownValue,
                                description: descriptionController.text)
                            .toMap());
                        print('lllll');
                      } catch (e) {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              Future.delayed((const Duration(seconds: 2)), () {
                                Navigator.of(context).pop();
                              });
                              return AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                title: Image.asset('assets/images/alert_password.png'),
                                content: Text(
                                  e.toString(),
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.H4(color: Colors.red),
                                ),
                              );
                            });
                      }
                      EasyLoading.dismiss();
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                    color: Colors.red,
                    child: Text('Tai len bai hat'),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
