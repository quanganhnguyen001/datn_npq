import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn_npq/auth/model/user_model.dart';
import 'package:datn_npq/models/song_model.dart';
import 'package:datn_npq/widgets/seekbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class FavoriteSCreen extends StatefulWidget {
  const FavoriteSCreen({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<FavoriteSCreen> createState() => _FavoriteSCreenState();
}

class _FavoriteSCreenState extends State<FavoriteSCreen> {
  bool hovering = false;
  bool isPlaying = false;
  int songIndex = 0;
  AudioPlayer audioPlayer = AudioPlayer();
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
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: widget.userModel.favoriteSong?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        Text(
                          '${index + 1}',
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
                              Image.network('${widget.userModel.favoriteSong?[index].coverUrl}'),
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
                                          // indexPlaying = index1;
                                          audioPlayer.setAudioSource(
                                            ConcatenatingAudioSource(
                                                children: [AudioSource.uri(Uri.parse(widget.userModel.favoriteSong?[index].url ?? ''))]),
                                          );
                                          songIndex = index;
                                          isPlaying = true;
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
                    '${widget.userModel.favoriteSong?[index].title}',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${widget.userModel.favoriteSong?[index].description}'),
                  trailing: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.userModel.favoriteSong?.remove(widget.userModel.favoriteSong?[index]);
                      });

                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update(UserModel(favoriteSong: widget.userModel.favoriteSong).toMap());
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Xoa thanh cong'),
                        duration: Duration(seconds: 2),
                      ));
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                );
              },
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          Image.network(
                            widget.userModel.favoriteSong?[songIndex].coverUrl ?? '',
                            width: 100,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            children: [
                              Text(
                                widget.userModel.favoriteSong?[songIndex].title ?? '',
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                widget.userModel.favoriteSong?[songIndex].description ?? '',
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
                                            if (songIndex > 0) {
                                              songIndex = songIndex - 1;
                                            } else {
                                              return;
                                            }
                                            audioPlayer.setAudioSource(
                                              ConcatenatingAudioSource(
                                                  children: [AudioSource.uri(Uri.parse(widget.userModel.favoriteSong?[songIndex].url ?? ''))]),
                                            );
                                          });
                                        },
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
                                          return IconButton(
                                            icon: const Icon(
                                              Icons.replay_circle_filled_outlined,
                                              color: Colors.white,
                                            ),
                                            iconSize: 55.0,
                                            onPressed: () => audioPlayer.seek(
                                              Duration.zero,
                                              index: audioPlayer.effectiveIndices!.first,
                                            ),
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
                                            if (songIndex != (widget.userModel.favoriteSong?.length ?? 0) - 1) {
                                              songIndex = songIndex + 1;
                                            } else {
                                              return;
                                            }
                                            audioPlayer.setAudioSource(
                                              ConcatenatingAudioSource(
                                                  children: [AudioSource.uri(Uri.parse(widget.userModel.favoriteSong?[songIndex].url ?? ''))]),
                                            );
                                          });
                                        },
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
                    ),
                  ))
              : Container()
        ],
      ),
    );
  }
}
