import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn_npq/models/my_playlist.dart';
import 'package:datn_npq/models/song_model.dart';
import 'package:equatable/equatable.dart';

part 'myuplaylist_cubit_state.dart';

class MyuplaylistCubitCubit extends Cubit<MyuplaylistCubitState> {
  MyuplaylistCubitCubit() : super(MyuplaylistCubitState([]));

  fetchMyPlaylistList() {
    FirebaseFirestore.instance.collection('myPlaylist').snapshots().listen((QuerySnapshot snapshot) {
      List<MyPlaylistModel> songListFetchMyplaylist = [];

      for (var doc in snapshot.docs) {
        var myPlayListSong = doc['myPlaylistSong'] as List<dynamic>;
        List<Song> songs = myPlayListSong.map((item) => Song.fromMap(item)).toList();
        songListFetchMyplaylist.add(MyPlaylistModel(name: doc['name'], myPlaylistId: doc.id, myPlaylistSong: songs));
      }

      emit(state.copyWith(myPlayListList: songListFetchMyplaylist));
    });
  }
}
