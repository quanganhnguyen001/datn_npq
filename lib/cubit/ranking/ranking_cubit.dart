import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../models/song_model.dart';

part 'ranking_state.dart';

class RankingCubit extends Cubit<RankingState> {
  RankingCubit() : super(RankingState([]));

  fetchDataSonglist() {
    FirebaseFirestore.instance.collection('song').snapshots().listen((QuerySnapshot snapshot) {
      List<Song> rankingSong = [];
      for (var doc in snapshot.docs) {
        rankingSong.add(Song(
            description: doc['description'],
            title: doc['title'],
            url: doc['url'],
            coverUrl: doc['coverUrl'],
            isTrending: doc['isTrending'],
            view: doc['view'],
            songId: doc.id));
      }
      rankingSong.sort((a, b) => (b.view?.compareTo((a.view ?? 0))) ?? 0);
      emit(state.copyWith(rankingList: rankingSong));
    });
  }
}
