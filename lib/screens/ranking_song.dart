import 'package:datn_npq/cubit/ranking/ranking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RankingSong extends StatelessWidget {
  const RankingSong({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200.withOpacity(0.8),
      body: BlocBuilder<RankingCubit, RankingState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'Bang Xep Hang',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
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
                            Image.network(state.rankingList[index].coverUrl ?? ''),
                          ],
                        ),
                      ),
                      subtitle: Text(state.rankingList[index].description ?? ''),
                      trailing: Text(state.rankingList[index].view.toString()));
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
      ),
    );
  }
}
