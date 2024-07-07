import 'package:datn_npq/cubit/ranking/ranking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RankingWidget extends StatelessWidget {
  const RankingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RankingCubit, RankingState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Expanded(
                child: ListView.separated(
              itemCount: state.rankingList.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(
                      state.rankingList[index].title ?? '',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    leading: SizedBox(
                      width: 110,
                      child: Row(
                        children: [
                          Text(
                            '${index + 1}',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Image.network(
                            state.rankingList[index].coverUrl ?? '',
                            width: 75,
                          ),
                        ],
                      ),
                    ),
                    subtitle: Text(state.rankingList[index].description ?? ''),
                    trailing: SizedBox(
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Lượt xem',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                          Text(
                            state.rankingList[index].view.toString(),
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                    ));
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.white,
                );
              },
            )),
          ],
        );
      },
    );
  }
}
