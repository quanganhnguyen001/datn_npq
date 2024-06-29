import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn_npq/cubit/music/music_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

import '../models/song_model.dart';
import '../widgets/widgets.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({Key? key, required this.song, required this.index}) : super(key: key);
  final List<Song> song;
  final int index;

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  List<AudioSource> listAudioSource = [];
  int indexPlaying = 0;
  bool isLoading = true;
  int _counter = 0;
  Timer? _timer;

  @override
  void initState() {
    indexPlaying = widget.index;
    listAudioSource.add(AudioSource.uri(Uri.parse(widget.song[widget.index].url ?? '')));
    for (var i in context.read<MusicCubit>().state.songList) {
      if (i.url != widget.song[widget.index].url) {
        listAudioSource.add(AudioSource.uri(Uri.parse(i.url ?? '')));
      }
    }

    super.initState();

    audioPlayer.setAudioSource(
      ConcatenatingAudioSource(children: listAudioSource),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Stream<SeekBarData> get _seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(audioPlayer.positionStream, audioPlayer.durationStream, (
        Duration position,
        Duration? duration,
      ) {
        _timer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
          _counter++;
        });
        // print(position.toString().split('0:00:').last);
        if (_counter == 10) {
          FirebaseFirestore.instance
              .collection('song')
              .doc(widget.song[widget.index].songId)
              .update(Song(view: (widget.song[widget.index].view ?? 0) + 1).toMap());
        }
        // if (position.toString().split('0:00:').last.toString() == '10.154000') {
        //   print('OKKKKKK');
        //   // FirebaseFirestore.instance
        //   //     .collection('song')
        //   //     .doc(widget.song[widget.index].songId)
        //   //     .update(Song(view: (widget.song[widget.index].view) ?? 0 + 1).toMap());
        // }

        return SeekBarData(
          position,
          duration ?? Duration.zero,
        );
      });

  @override
  Widget build(BuildContext context) {
    print(widget.song[widget.index].view);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
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
          ),
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              CircleAvatar(
                radius: 150,
                backgroundImage: NetworkImage(
                  widget.song[indexPlaying].coverUrl ?? '',
                ),
              ),
              const _BackgroundFilter(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 30.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.song[indexPlaying].title ?? '',
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.song[indexPlaying].description ?? '',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 30),
                    StreamBuilder<SeekBarData>(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder<SequenceState?>(
                          stream: audioPlayer.sequenceStateStream,
                          builder: (context, index) {
                            return IconButton(
                              onPressed: () {
                                setState(() {
                                  if (audioPlayer.hasPrevious) {
                                    audioPlayer.seekToPrevious();
                                    indexPlaying -= 1;
                                  } else {
                                    return;
                                  }
                                });
                              },
                              // onPressed: audioPlayer.hasPrevious
                              //     ? audioPlayer.seekToPrevious
                              //     : null,
                              iconSize: 45,
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
                                  width: 64.0,
                                  height: 64.0,
                                  margin: const EdgeInsets.all(10.0),
                                  child: const CircularProgressIndicator(),
                                );
                              } else if (!audioPlayer.playing) {
                                return IconButton(
                                  onPressed: audioPlayer.play,
                                  iconSize: 75,
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
                                  iconSize: 75.0,
                                  onPressed: audioPlayer.pause,
                                );
                              } else {
                                return IconButton(
                                  icon: const Icon(
                                    Icons.replay_circle_filled_outlined,
                                    color: Colors.white,
                                  ),
                                  iconSize: 75.0,
                                  onPressed: () {},
                                );
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
                                  if (audioPlayer.hasNext) {
                                    audioPlayer.seekToNext();
                                    indexPlaying += 1;
                                  } else {
                                    return;
                                  }
                                });
                              },
                              iconSize: 45,
                              icon: const Icon(
                                Icons.skip_next,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _BackgroundFilter extends StatelessWidget {
  const _BackgroundFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
          Colors.white,
          Colors.white.withOpacity(0.5),
          Colors.white.withOpacity(0.0),
        ], stops: const [
          0.0,
          0.4,
          0.6
        ]).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade200,
              Colors.deepPurple.shade800,
            ],
          ),
        ),
      ),
    );
  }
}
