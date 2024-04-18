part of 'upload_song_cubit.dart';

class UploadSongState extends Equatable {
  const UploadSongState(this.playList, this.songList);
  final List<Playlist> playList;
  final List<Song> songList;

  @override
  List<Object> get props => [playList, songList];

  UploadSongState copyWith({
    List<Playlist>? playList,
    List<Song>? songList,
  }) {
    return UploadSongState(
      playList ?? this.playList,
      songList ?? this.songList,
    );
  }
}
