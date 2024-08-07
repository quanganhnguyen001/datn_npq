import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn_npq/auth/model/user_model.dart';
import 'package:datn_npq/models/playlist_model.dart';
import 'package:equatable/equatable.dart';

import '../../models/song_model.dart';

part 'upload_song_state.dart';

class UploadSongCubit extends Cubit<UploadSongState> {
  UploadSongCubit() : super(UploadSongState([], [], []));

  fetchData() {
    fetchDataPlaylist();
    fetchDataSonglist();
    fetchListUser();
  }

  fetchDataPlaylist() {
    FirebaseFirestore.instance.collection('playlist').snapshots().listen((QuerySnapshot snapshot) {
      List<Playlist> playListFetch = [];
      for (var doc in snapshot.docs) {
        var songsList = doc['songs'] as List<dynamic>;
        List<Song> songs = songsList.map((item) => Song.fromMap(item)).toList();

        playListFetch.add(Playlist(imageUrl: doc['imageUrl'], songs: songs, title: doc['title'], playlistId: doc.id));
      }

      emit(state.copyWith(playList: playListFetch));
    });
  }

  fetchDataSonglist() {
    FirebaseFirestore.instance.collection('song').snapshots().listen((QuerySnapshot snapshot) {
      List<Song> songListFetch = [];
      for (var doc in snapshot.docs) {
        songListFetch.add(Song(
            description: doc['description'],
            title: doc['title'],
            url: doc['url'],
            view: doc['view'],
            coverUrl: doc['coverUrl'],
            isTrending: doc['isTrending'],
            dropDownValue: doc['dropDownValue'],
            artistName: doc['artistName'],
            type: doc['type'],
            songId: doc.id));
      }

      emit(state.copyWith(songList: songListFetch));
    });
  }

  fetchListUser() {
    FirebaseFirestore.instance.collection('users').snapshots().listen((QuerySnapshot snapshot) {
      List<UserModel> listUserFetch = [];
      for (var doc in snapshot.docs) {
        listUserFetch.add(UserModel(uid: doc.id, name: doc['name'], email: doc['email'], imageUrl: doc['imageUrl'], phone: doc['phone']));
      }

      emit(state.copyWith(listUser: listUserFetch));
    });
  }
}
