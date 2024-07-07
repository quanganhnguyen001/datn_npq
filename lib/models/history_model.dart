import 'dart:convert';

import 'package:datn_npq/models/song_model.dart';

class HistoryModel {
  String? myPlaylistId;
  List<Song>? myPlaylistSong;
  HistoryModel({
    this.myPlaylistId,
    this.myPlaylistSong,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (myPlaylistId != null) {
      result.addAll({'myPlaylistId': myPlaylistId});
    }
    if (myPlaylistSong != null) {
      result.addAll({'myPlaylistSong': myPlaylistSong!.map((x) => x?.toMap()).toList()});
    }

    return result;
  }

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      myPlaylistId: map['myPlaylistId'],
      myPlaylistSong: map['myPlaylistSong'] != null ? List<Song>.from(map['myPlaylistSong']?.map((x) => Song.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryModel.fromJson(String source) => HistoryModel.fromMap(json.decode(source));
}
