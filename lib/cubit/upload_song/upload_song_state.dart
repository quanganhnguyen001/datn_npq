part of 'upload_song_cubit.dart';

class UploadSongState extends Equatable {
  const UploadSongState(this.playList, this.songList, this.listUser);
  final List<Playlist> playList;
  final List<Song> songList;
  final List<UserModel> listUser;

  @override
  List<Object> get props => [playList, songList, listUser];

  UploadSongState copyWith({
    List<Playlist>? playList,
    List<Song>? songList,
    List<UserModel>? listUser,
  }) {
    return UploadSongState(
      playList ?? this.playList,
      songList ?? this.songList,
      listUser ?? this.listUser,
    );
  }
}
