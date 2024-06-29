import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn_npq/models/song_model.dart';
import 'package:equatable/equatable.dart';

import '../../models/playlist_model.dart';

part 'music_state.dart';

class MusicCubit extends Cubit<MusicState> {
  MusicCubit() : super(MusicState([], [], [], []));

  fetchData() {
    fetchDataPlaylist();
    fetchDataSonglist();
    fetchDataInterlist();
    fetchDataVnlist();
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
    FirebaseFirestore.instance.collection('song').where('isTrending', isEqualTo: true).snapshots().listen((QuerySnapshot snapshot) {
      List<Song> songListFetch = [];
      for (var doc in snapshot.docs) {
        songListFetch.add(Song(
            description: doc['description'],
            title: doc['title'],
            url: doc['url'],
            coverUrl: doc['coverUrl'],
            isTrending: doc['isTrending'],
            view: doc['view'],
            artistName: doc['artistName'],
            type: doc['type'],
            songId: doc.id));
      }

      emit(state.copyWith(songList: songListFetch));
    });
  }

  fetchDataVnlist() {
    FirebaseFirestore.instance.collection('song').where('type', isEqualTo: 'Việt Nam').snapshots().listen((QuerySnapshot snapshot) {
      List<Song> songListFetchVN = [];
      for (var doc in snapshot.docs) {
        songListFetchVN.add(Song(
            description: doc['description'],
            title: doc['title'],
            url: doc['url'],
            coverUrl: doc['coverUrl'],
            isTrending: doc['isTrending'],
            view: doc['view'],
            artistName: doc['artistName'],
            type: doc['type'],
            songId: doc.id));
      }
      print('viet nammmmmmmmmm ${songListFetchVN.length}');

      emit(state.copyWith(vnList: songListFetchVN));
      print(state.vnList[0].title);
    });
  }

  fetchDataInterlist() {
    FirebaseFirestore.instance.collection('song').where('type', isEqualTo: 'Quốc Tế').snapshots().listen((QuerySnapshot snapshot) {
      List<Song> songListFetchInter = [];
      for (var doc in snapshot.docs) {
        songListFetchInter.add(Song(
            description: doc['description'],
            title: doc['title'],
            url: doc['url'],
            coverUrl: doc['coverUrl'],
            isTrending: doc['isTrending'],
            view: doc['view'],
            artistName: doc['artistName'],
            type: doc['type'],
            songId: doc.id));
      }
      print('quoc teeeeeeeeeeeee ${songListFetchInter.length}');

      emit(state.copyWith(interList: songListFetchInter));
    });
  }
}
