part of 'ranking_cubit.dart';

class RankingState extends Equatable {
  const RankingState(this.rankingList);
  final List<Song> rankingList;

  @override
  List<Object> get props => [rankingList];

  RankingState copyWith({
    List<Song>? rankingList,
  }) {
    return RankingState(
      rankingList ?? this.rankingList,
    );
  }
}
