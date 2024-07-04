import 'dart:convert';

import 'package:datn_npq/models/song_model.dart';

class MyPlaylistModel {
  String? name;
  String? myPlaylistId;
  List<Song>? myPlaylistSong;
  MyPlaylistModel({
    this.name,
    this.myPlaylistId,
    this.myPlaylistSong,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (name != null) {
      result.addAll({'name': name});
    }
    if (myPlaylistId != null) {
      result.addAll({'myPlaylistId': myPlaylistId});
    }
    if (myPlaylistSong != null) {
      result.addAll({'myPlaylistSong': myPlaylistSong!.map((x) => x?.toMap()).toList()});
    }

    return result;
  }

  factory MyPlaylistModel.fromMap(Map<String, dynamic> map) {
    return MyPlaylistModel(
      name: map['name'],
      myPlaylistId: map['myPlaylistId'],
      myPlaylistSong: map['myPlaylistSong'] != null ? List<Song>.from(map['myPlaylistSong']?.map((x) => Song.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyPlaylistModel.fromJson(String source) => MyPlaylistModel.fromMap(json.decode(source));
}
