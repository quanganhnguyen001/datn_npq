import 'dart:html' as html;
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn_npq/cubit/upload_song/upload_song_cubit.dart';
import 'package:datn_npq/models/playlist_model.dart';
import 'package:datn_npq/models/song_model.dart';
import 'package:datn_npq/theme/app_style.dart';
import 'package:datn_npq/theme/color_paletes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path/path.dart' as path;

class UpdateSong extends StatefulWidget {
  const UpdateSong({super.key, required this.song});
  final Song song;

  @override
  State<UpdateSong> createState() => _UpdateSongState();
}

class _UpdateSongState extends State<UpdateSong> {
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
  bool? isTrending;

  @override
  void initState() {
    titleController.text = widget.song.title ?? '';
    descriptionController.text = widget.song.description ?? '';
    isTrending = widget.song.isTrending;
    dropDownValue = widget.song.dropDownValue ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String url = widget.song.url ?? '';
    String fileName = path.basename(url);

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
                              decoration: BoxDecoration(border: Border.all(width: 3, color: ColorPalettes.secondaryColor)),
                              child: Image.network(widget.song.coverUrl ?? ''),
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
                      child: SizedBox(
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          songPicked == '' ? (fileName) : songPicked,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        CupertinoSwitch(
                            value: isTrending ?? false,
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
                GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      if (imageSong != null && audioFile != null) {
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

                          FirebaseFirestore.instance.collection('song').doc(widget.song.songId).update(Song(
                                  title: titleController.text,
                                  coverUrl: imageUrl,
                                  dropDownValue: dropDownValue,
                                  url: audioUrl,
                                  view: 0,
                                  isTrending: widget.song.isTrending,
                                  description: descriptionController.text)
                              .toMap());
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
                      } else {
                        EasyLoading.show();
                        try {
                          FirebaseFirestore.instance.collection('song').doc(widget.song.songId).update(
                              Song(view: 0, title: titleController.text, isTrending: isTrending, description: descriptionController.text).toMap());
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
                    }
                  },
                  child: Container(
                    color: Colors.red,
                    child: Text('Cap nhat bai hat'),
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
