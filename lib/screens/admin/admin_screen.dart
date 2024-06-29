import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn_npq/cubit/upload_song/upload_song_cubit.dart';
import 'package:datn_npq/screens/admin/widget/update_playlist.dart';
import 'package:datn_npq/screens/admin/widget/update_song.dart';
import 'package:datn_npq/screens/admin/widget/upload_playlist_widget.dart';
import 'package:datn_npq/screens/admin/widget/upload_song_widget.dart';
import 'package:datn_npq/screens/login_screen.dart';
import 'package:datn_npq/widgets/playlist_card.dart';
import 'package:datn_npq/widgets/playlist_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
            },
            icon: const Icon(Icons.logout_outlined),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.green,
            labelColor: Colors.green,
            tabs: [
              Tab(
                child: Text('Danh sách album', textAlign: TextAlign.center),
              ),
              Tab(
                child: Text(
                  'Danh sách bai hat',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          centerTitle: true,
          title: const Text(
            'Admin',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                showMenu(context: context, position: const RelativeRect.fromLTRB(100, 50, 0, 0), items: [
                  PopupMenuItem(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UploadPlaylistWidget()));
                      },
                      child: const Text('Thêm album')),
                  PopupMenuItem(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UploadSongWidget()));
                      },
                      child: const Text('Them Bai hat')),
                ]);
              },
              child: Container(margin: const EdgeInsets.only(right: 20), child: const Icon(Icons.add)),
            ),
          ],
        ),
        body: BlocBuilder<UploadSongCubit, UploadSongState>(
          builder: (context, state) {
            return TabBarView(
              children: [
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 20),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.playList.length,
                    itemBuilder: ((context, index) {
                      return PlaylistCard(
                        playlist: state.playList[index],
                        onTap: () {},
                        onPressedEdit: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdatePlaylist(playlist: state.playList[index])));
                        },
                        onPressed: () async {
                          await FirebaseFirestore.instance.collection('playlist').doc(state.playList[index].playlistId).delete();
                        },
                      );
                    }),
                  ),
                ),
                Container(
                  child: ListView.builder(
                    itemCount: state.songList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 75,
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade800.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                state.songList[index].coverUrl ?? '',
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    state.songList[index].title ?? '',
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${state.songList[index].description} ',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            FirebaseAuth.instance.currentUser == null
                                ? IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => UpdateSong(
                                                song: state.songList[index],
                                              )));
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    ),
                                  )
                                : Container(),
                            FirebaseAuth.instance.currentUser == null
                                ? IconButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance.collection('song').doc(state.songList[index].songId).delete();
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      );
                    },
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
