import 'dart:html' as html;
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn_npq/models/playlist_model.dart';
import 'package:datn_npq/theme/app_style.dart';
import 'package:datn_npq/theme/color_paletes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UpdatePlaylist extends StatefulWidget {
  const UpdatePlaylist({super.key, required this.playlist});
  final Playlist playlist;

  @override
  State<UpdatePlaylist> createState() => _UpdatePlaylistState();
}

class _UpdatePlaylistState extends State<UpdatePlaylist> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  Uint8List? imagePlaylist;
  String name = '';

  @override
  void initState() {
    titleController.text = widget.playlist.title ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
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
                      imagePlaylist = file.files.first.bytes;
                      name = file.files.first.name;
                    });
                  }
                },
                child: imagePlaylist == null
                    ? Center(
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 3,
                                  color: ColorPalettes.secondaryColor)),
                          child: Image.network(widget.playlist.imageUrl ?? ''),
                        ),
                      )
                    : Center(
                        child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 3,
                                    color: ColorPalettes.secondaryColor)),
                            child: Image.memory(imagePlaylist ?? Uint8List(0))),
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
                    return 'Vui lòng nhập tên playlist';
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
                  hintText: 'Nhập tên playlist của bạn',
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  if (imagePlaylist != null) {
                    EasyLoading.show();
                    try {
                      html.Blob blob = html.Blob([imagePlaylist]);
                      FirebaseStorage storage = FirebaseStorage.instance;
                      final ref = FirebaseStorage.instance
                          .ref()
                          .child('playListImage')
                          .child(name);
                      if (imagePlaylist != null) {
                        await ref.putBlob(blob);
                      }

                      String imageUrl = await ref.getDownloadURL();
                      FirebaseFirestore.instance
                          .collection('playlist')
                          .doc(widget.playlist.playlistId)
                          .update(Playlist(
                            title: titleController.text,
                            imageUrl: imageUrl,
                          ).toMap());
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            Future.delayed((const Duration(seconds: 2)), () {
                              Navigator.of(context).pop();
                            });
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              title: Image.asset(
                                  'assets/images/alert_password.png'),
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
                      FirebaseFirestore.instance
                          .collection('playlist')
                          .doc(widget.playlist.playlistId)
                          .update(Playlist(
                            title: titleController.text,
                          ).toMap());
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            Future.delayed((const Duration(seconds: 2)), () {
                              Navigator.of(context).pop();
                            });
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              title: Image.asset(
                                  'assets/images/alert_password.png'),
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
                child: Text('Cap nhat playlist'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
