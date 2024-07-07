import 'dart:convert';

class Song {
  final String? title;
  final String? description;
  final String? url;
  final String? coverUrl;
  final String? songId;
  final bool? isTrending;
  final String? dropDownValue;
  final int? view;
  final String? artistName;
  final String? type;
  final bool? isExist;

  Song(
      {this.title,
      this.description,
      this.url,
      this.coverUrl,
      this.songId,
      this.isTrending,
      this.dropDownValue,
      this.view,
      this.artistName,
      this.type,
      this.isExist});

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
    if (dropDownValue != null) {
      result.addAll({'dropDownValue': dropDownValue});
    }
    if (view != null) {
      result.addAll({'view': view});
    }
    if (artistName != null) {
      result.addAll({'artistName': artistName});
    }
    if (type != null) {
      result.addAll({'type': type});
    }
    if (isExist != null) {
      result.addAll({'isExist': isExist});
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
      dropDownValue: map['dropDownValue'],
      view: map['view']?.toInt(),
      artistName: map['artistName'],
      type: map['type'],
      isExist: map['isExist'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Song.fromJson(String source) => Song.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Song(title: $title, description: $description, url: $url, coverUrl: $coverUrl, songId: $songId, isTrending: $isTrending)';
  }
}
