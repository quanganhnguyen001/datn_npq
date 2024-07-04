import 'package:datn_npq/cubit/cubit/myuplaylist_cubit_cubit.dart';
import 'package:datn_npq/widgets/seekbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class MyplaylistDetail extends StatefulWidget {
  const MyplaylistDetail({
    Key? key,
    required this.index,
    required this.title,
    required this.image,
  }) : super(key: key);
  final int index;
  final String title;
  final String image;

  @override
  State<MyplaylistDetail> createState() => _MyplaylistDetailState();
}

class _MyplaylistDetailState extends State<MyplaylistDetail> {
  AudioPlayer audioPlayer = AudioPlayer();
  int indexPlaying = 0;
  bool hovering = false;
  bool isLoading = true;
  bool isPlaying = false;

  Stream<SeekBarData> get _seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(audioPlayer.positionStream, audioPlayer.durationStream, (
        Duration position,
        Duration? duration,
      ) {
        return SeekBarData(
          position,
          duration ?? Duration.zero,
        );
      });
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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Column(
                      children: [
                        _PlaylistInformation(
                          index: widget.index,
                          title: widget.title,
                          image: widget.image,
                        ),
                        const SizedBox(height: 30),
                        BlocBuilder<MyuplaylistCubitCubit, MyuplaylistCubitState>(
                          builder: (context, state) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.myPlayListList[widget.index].myPlaylistSong?.length,
                              itemBuilder: (context, index1) {
                                return ListTile(
                                  leading: SizedBox(
                                    width: 150,
                                    child: Row(
                                      children: [
                                        Text(
                                          '${index1 + 1}',
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        MouseRegion(
                                          onEnter: (_) {
                                            setState(() {
                                              hovering = true;
                                            });
                                          },
                                          onExit: (_) {
                                            setState(() {
                                              hovering = false;
                                            });
                                          },
                                          child: Stack(
                                            children: [
                                              Image.network(
                                                state.myPlayListList[widget.index].myPlaylistSong?[index1].coverUrl ?? '',
                                                fit: BoxFit.cover,
                                              ),
                                              AnimatedOpacity(
                                                duration: const Duration(milliseconds: 200),
                                                opacity: hovering ? 1.0 : 0.0,
                                                child: Container(
                                                  width: 70,
                                                  color: Colors.black.withOpacity(0.5), // Adjust the color and opacity here
                                                  child: Center(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          indexPlaying = index1;
                                                          audioPlayer.setAudioSource(
                                                            ConcatenatingAudioSource(children: [
                                                              AudioSource.uri(Uri.parse(
                                                                  state.myPlayListList[widget.index].myPlaylistSong?[indexPlaying].url ?? ''))
                                                            ]),
                                                          );

                                                          isPlaying = true;
                                                          // audioUrl = state
                                                          //     .playList[
                                                          //         widget.index]
                                                          //     .songs?[index1]
                                                          //     .url;
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.play_circle_fill, // Replace with your icon

                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  title: Text(
                                    state.myPlayListList[widget.index].myPlaylistSong?[index1].title ?? '',
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text('${state.myPlayListList[widget.index].myPlaylistSong?[index1].description}'),
                                );
                              },
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            isPlaying == true
                ? Positioned(
                    bottom: 0,
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
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
                      child: BlocBuilder<MyuplaylistCubitCubit, MyuplaylistCubitState>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              children: [
                                Image.network(
                                  state.myPlayListList[widget.index].myPlaylistSong?[indexPlaying].coverUrl ?? '',
                                  width: 100,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      state.myPlayListList[widget.index].myPlaylistSong?[indexPlaying].title ?? '',
                                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      state.myPlayListList[widget.index].myPlaylistSong?[indexPlaying].description ?? '',
                                      maxLines: 2,
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 200,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        StreamBuilder<SequenceState?>(
                                          stream: audioPlayer.sequenceStateStream,
                                          builder: (context, index) {
                                            return IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (indexPlaying > 0) {
                                                    indexPlaying = indexPlaying - 1;
                                                  } else {
                                                    return;
                                                  }
                                                  audioPlayer.setAudioSource(
                                                    ConcatenatingAudioSource(children: [
                                                      AudioSource.uri(
                                                          Uri.parse(state.myPlayListList[widget.index].myPlaylistSong?[indexPlaying].url ?? ''))
                                                    ]),
                                                  );
                                                });
                                              },
                                              // onPressed: audioPlayer.hasPrevious
                                              //     ? audioPlayer.seekToPrevious
                                              //     : null,
                                              iconSize: 25,
                                              icon: const Icon(
                                                Icons.skip_previous,
                                                color: Colors.white,
                                              ),
                                            );
                                          },
                                        ),
                                        StreamBuilder<PlayerState>(
                                          stream: audioPlayer.playerStateStream,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              final playerState = snapshot.data;
                                              final processingState = playerState!.processingState;

                                              if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
                                                return Container(
                                                  margin: const EdgeInsets.all(10.0),
                                                  child: const CircularProgressIndicator(),
                                                );
                                              } else if (!audioPlayer.playing) {
                                                return IconButton(
                                                  onPressed: audioPlayer.play,
                                                  iconSize: 43,
                                                  icon: const Icon(
                                                    Icons.play_circle,
                                                    color: Colors.white,
                                                  ),
                                                );
                                              } else if (processingState != ProcessingState.completed) {
                                                return IconButton(
                                                  icon: const Icon(
                                                    Icons.pause_circle,
                                                    color: Colors.white,
                                                  ),
                                                  iconSize: 43.0,
                                                  onPressed: audioPlayer.pause,
                                                );
                                              } else {
                                                if (isLoading) {
                                                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                                                    setState(() {
                                                      if (indexPlaying != (state.myPlayListList[widget.index].myPlaylistSong?.length ?? 0) - 1) {
                                                        indexPlaying = indexPlaying + 1;
                                                        isLoading = false;
                                                      } else {
                                                        return;
                                                      }
                                                      audioPlayer.setAudioSource(
                                                        ConcatenatingAudioSource(children: [
                                                          AudioSource.uri(
                                                              Uri.parse(state.myPlayListList[widget.index].myPlaylistSong?[indexPlaying].url ?? ''))
                                                        ]),
                                                      );
                                                    });
                                                  });
                                                }
                                                return isLoading
                                                    ? CircularProgressIndicator()
                                                    : IconButton(
                                                        icon: const Icon(
                                                          Icons.replay_circle_filled_outlined,
                                                          color: Colors.white,
                                                        ),
                                                        iconSize: 43.0,
                                                        onPressed: () {
                                                          setState(() {
                                                            audioPlayer.setAudioSource(
                                                              ConcatenatingAudioSource(
                                                                children: [
                                                                  AudioSource.uri(Uri.parse(
                                                                      state.myPlayListList[widget.index].myPlaylistSong?[indexPlaying].url ?? '')),
                                                                ],
                                                              ),
                                                            );
                                                          });
                                                        });
                                              }
                                            } else {
                                              return const CircularProgressIndicator();
                                            }
                                          },
                                        ),
                                        StreamBuilder<SequenceState?>(
                                          stream: audioPlayer.sequenceStateStream,
                                          builder: (context, index) {
                                            return IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (indexPlaying != (state.myPlayListList[widget.index].myPlaylistSong?.length ?? 0) - 1) {
                                                    indexPlaying = indexPlaying + 1;
                                                  } else {
                                                    return;
                                                  }
                                                  audioPlayer.setAudioSource(
                                                    ConcatenatingAudioSource(children: [
                                                      AudioSource.uri(
                                                          Uri.parse(state.myPlayListList[widget.index].myPlaylistSong?[indexPlaying].url ?? ''))
                                                    ]),
                                                  );
                                                });
                                              },
                                              // onPressed: audioPlayer.hasNext
                                              //     ? audioPlayer.seekToNext
                                              //     : null,
                                              iconSize: 25,
                                              icon: const Icon(
                                                Icons.skip_next,
                                                color: Colors.white,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 600,
                                      child: StreamBuilder<SeekBarData>(
                                        stream: _seekBarDataStream,
                                        builder: (context, snapshot) {
                                          final positionData = snapshot.data;
                                          return SeekBar(
                                            position: positionData?.position ?? Duration.zero,
                                            duration: positionData?.duration ?? Duration.zero,
                                            onChangeEnd: audioPlayer.seek,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class _PlaylistInformation extends StatelessWidget {
  const _PlaylistInformation({
    Key? key,
    required this.index,
    required this.title,
    required this.image,
  }) : super(key: key);
  final int index;
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyuplaylistCubitCubit, MyuplaylistCubitState>(
      builder: (context, state) {
        return Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                image,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}
