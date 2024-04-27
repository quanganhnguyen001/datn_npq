import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn_npq/models/song_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../auth/model/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState(null));

  Future<void> loadUserData() async {
    final user = await _loadUserData();

    if (user != null) {
      emit(UserState(user));
    }
  }

  Future<UserModel?> _loadUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (FirebaseAuth.instance.currentUser != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();
        var songs = userSnapshot['favoriteSong'];
        List<Song> favoriteSongs = [];
        if (songs != null) {
          favoriteSongs = List<Song>.from(songs
              .map((songMap) => Song.fromMap(songMap as Map<String, dynamic>)));
        }
        return UserModel(
          imageUrl: userSnapshot['imageUrl'],
          name: userSnapshot['name'],
          email: userSnapshot['email'],
          phone: userSnapshot['phone'],
          favoriteSong: favoriteSongs,
        );
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
