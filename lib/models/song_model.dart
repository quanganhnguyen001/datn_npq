import 'dart:convert';

class Song {
  final String? title;
  final String? description;
  final String? url;
  final String? coverUrl;
  final String? songId;
  final bool? isTrending;

  Song({
    this.title,
    this.description,
    this.url,
    this.coverUrl,
    this.songId,
    this.isTrending,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (title != null) {
      result.addAll({'title': title});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (url != null) {
      result.addAll({'url': url});
    }
    if (coverUrl != null) {
      result.addAll({'coverUrl': coverUrl});
    }
    if (songId != null) {
      result.addAll({'songId': songId});
    }
    if (isTrending != null) {
      result.addAll({'isTrending': isTrending});
    }

    return result;
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      title: map['title'],
      description: map['description'],
      url: map['url'],
      coverUrl: map['coverUrl'],
      songId: map['songId'],
      isTrending: map['isTrending'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Song.fromJson(String source) => Song.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Song(title: $title, description: $description, url: $url, coverUrl: $coverUrl, songId: $songId, isTrending: $isTrending)';
  }
}
