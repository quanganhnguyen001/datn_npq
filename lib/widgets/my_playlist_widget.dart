import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn_npq/cubit/cubit/myuplaylist_cubit_cubit.dart';
import 'package:datn_npq/cubit/music/music_cubit.dart';
import 'package:datn_npq/models/my_playlist.dart';
import 'package:datn_npq/models/song_model.dart';
import 'package:datn_npq/screens/admin/widget/myplay;list_detaild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MyPlaylistWidget extends StatefulWidget {
  const MyPlaylistWidget({super.key});

  @override
  State<MyPlaylistWidget> createState() => _MyPlaylistWidgetState();
}

class _MyPlaylistWidgetState extends State<MyPlaylistWidget> {
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyuplaylistCubitCubit, MyuplaylistCubitState>(
      builder: (context, state) {
        return Stack(
          children: [
            Positioned(
              right: 20,
              bottom: 20,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        print('1111');
                        return Container(
                          width: 300,
                          height: 200,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Nhap ten Playlist',
                                  style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.red),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: nameController,
                                  style: TextStyle(color: Colors.black),
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
                                    hintText: 'Tên playlist',
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance.collection('myPlaylist').doc().set(MyPlaylistModel(
                                            name: nameController.text,
                                            myPlaylistSong: [],
                                          ).toMap());

                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Xac nhan'))
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                  child: Icon(Icons.add),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Danh sach phat cua toi',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 400,
                  child: ListView.builder(
                      itemCount: state.myPlayListList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20, right: 800, left: 20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MyplaylistDetail(
                                        index: index,
                                        title: state.myPlayListList[index].name ?? '',
                                        image: state.myPlayListList[index].myPlaylistSong?.first.coverUrl ?? '',
                                      )));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: 300,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          state.myPlayListList[index].myPlaylistSong?.first.coverUrl ?? '',
                                        ),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [Text(state.myPlayListList[index].name ?? '')],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
