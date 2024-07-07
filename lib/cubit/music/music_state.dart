part of 'music_cubit.dart';

class MusicState extends Equatable {
  const MusicState(
    this.playList,
    this.songList,
    this.vnList,
    this.interList,
    this.historyList,
  );
  final List<Playlist> playList;
  final List<Song> songList;
  final List<Song> vnList;
  final List<Song> interList;
  final List<Song> historyList;

  @override
  List<Object> get props => [playList, songList, vnList, interList, historyList];

  MusicState copyWith({
    List<Playlist>? playList,
    List<Song>? songList,
    List<Song>? vnList,
    List<Song>? interList,
    List<Song>? historyList,
  }) {
    return MusicState(
      playList ?? this.playList,
      songList ?? this.songList,
      vnList ?? this.vnList,
      interList ?? this.interList,
      historyList ?? this.historyList,
    );
  }
}
