import 'package:datn_npq/auth/model/user_model.dart';
import 'package:datn_npq/cubit/music/music_cubit.dart';
import 'package:datn_npq/widgets/seekbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import 'package:rxdart/rxdart.dart' as rxdart;

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({
    super.key,
  });

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple.shade800.withOpacity(0.8),
            Colors.deepPurple.shade200.withOpacity(0.8),
          ],
        ),
      ),
      child: BlocBuilder<MusicCubit, MusicState>(
        builder: (context, state) {
          return Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: state.historyList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
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
                              '${state.historyList[index].coverUrl}',
                              width: 75,
                            ),
                          ],
                        ),
                      ),
                      title: Text(
                        '${state.historyList[index].title}',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('${state.historyList[index].description}'),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
