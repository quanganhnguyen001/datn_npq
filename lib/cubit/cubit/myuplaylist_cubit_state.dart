part of 'myuplaylist_cubit_cubit.dart';

class MyuplaylistCubitState extends Equatable {
  const MyuplaylistCubitState(this.myPlayListList);
  final List<MyPlaylistModel> myPlayListList;

  @override
  List<Object> get props => [myPlayListList];

  MyuplaylistCubitState copyWith({
    List<MyPlaylistModel>? myPlayListList,
  }) {
    return MyuplaylistCubitState(
      myPlayListList ?? this.myPlayListList,
    );
  }
}
