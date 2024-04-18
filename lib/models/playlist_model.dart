import 'dart:convert';

import 'song_model.dart';

class Playlist {
  final String? title;
  final List<Song>? songs;
  final String? imageUrl;
  final String? playlistId;

  Playlist({
    this.title,
    this.songs,
    this.imageUrl,
    this.playlistId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (title != null) {
      result.addAll({'title': title});
    }
    if (songs != null) {
      result.addAll({'songs': songs!.map((x) => x?.toMap()).toList()});
    }
    if (imageUrl != null) {
      result.addAll({'imageUrl': imageUrl});
    }
    if (playlistId != null) {
      result.addAll({'playlistId': playlistId});
    }

    return result;
  }

  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      title: map['title'],
      songs: map['songs'] != null
          ? List<Song>.from(map['songs']?.map((x) => Song.fromMap(x)))
          : null,
      imageUrl: map['imageUrl'],
      playlistId: map['playlistId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Playlist.fromJson(String source) =>
      Playlist.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Playlist(title: $title, songs: $songs, imageUrl: $imageUrl, playlistId: $playlistId)';
  }
}
