part of 'music_cubit.dart';

class MusicState extends Equatable {
  const MusicState(
    this.playList,
    this.songList,
  );
  final List<Playlist> playList;
  final List<Song> songList;
  @override
  List<Object> get props => [playList, songList];

  MusicState copyWith({
    List<Playlist>? playList,
    List<Song>? songList,
  }) {
    return MusicState(playList ?? this.playList, songList ?? this.songList);
  }
}
