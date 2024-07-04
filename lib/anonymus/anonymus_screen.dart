import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:datn_npq/anonymus/playlist_anonymous.dart';
import 'package:datn_npq/anonymus/playlist_anonymous_widget.dart';
import 'package:datn_npq/anonymus/song_anonymous.dart';
import 'package:datn_npq/cubit/music/music_cubit.dart';
import 'package:datn_npq/screens/login_screen.dart';
import 'package:datn_npq/screens/ranking_song.dart';
import 'package:datn_npq/widgets/section_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnonymusScreen extends StatefulWidget {
  const AnonymusScreen({super.key});

  @override
  State<AnonymusScreen> createState() => _AnonymusScreenState();
}

class _AnonymusScreenState extends State<AnonymusScreen> {
  final CarouselController _controller = CarouselController();
  int _currentIndex = 0;
  String selectedButton = 'Vietnam';
  @override
  void initState() {
    updateList('Vietnam');
    super.initState();
  }

  void updateList(String button) {
    setState(() {
      selectedButton = button;
      if (button == 'Vietnam') {
        // selectedButton = 'Vietnam';
      } else if (button == 'Quoc Te') {
        // selectedButton = 'Quoc Te';
      }
    });
  }

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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.list,
              size: 20,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push((MaterialPageRoute(builder: (context) => RankingSong())));
            },
          ),
          title: Text(
            'Quân MP3',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                child: Text(
                  'Đăng nhập',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        body: Container(
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Xin chào, ',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Tận hưởng giai diệu yêu thích của bạn',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Tìm kiếm',
                          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey.shade400),
                          prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    top: 20.0,
                    bottom: 20.0,
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: SectionHeader(title: ' Album'),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.27,
                        width: MediaQuery.of(context).size.width,
                        child: BlocBuilder<MusicCubit, MusicState>(
                          builder: (context, state) {
                            return state.playList.isEmpty
                                ? Center(child: CircularProgressIndicator())
                                : CarouselSlider.builder(
                                    carouselController: _controller,
                                    options: CarouselOptions(
                                      viewportFraction: 0.3,
                                      autoPlay: true,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _currentIndex = index;
                                        });
                                      },
                                    ),
                                    itemCount: state.playList.length,
                                    itemBuilder: (context, index, realIndex) {
                                      return PlaylistAnonymousWidget(
                                        index: index,
                                        playlist: state.playList[index],
                                      );
                                    },
                                  );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () => _controller.previousPage(),
                            child: Text('Back'),
                          ),
                          ElevatedButton(
                            onPressed: () => _controller.nextPage(),
                            child: Text('Next'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SectionHeader(
                        title: 'Thịnh hành',
                        onTap: () {},
                      ),
                      BlocBuilder<MusicCubit, MusicState>(
                        builder: (context, state) {
                          return GridView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(top: 20),
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, mainAxisExtent: 150, mainAxisSpacing: 10, crossAxisSpacing: 10),
                            itemCount: state.songList.length < 12 ? state.songList.length : 12,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SongAnonymous(
                                      song: state.songList,
                                      index: index,
                                    ),
                                  ));
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        state.songList[index].coverUrl ?? '',
                                        height: 100,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.songList[index].title ?? '',
                                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          state.songList[index].description ?? '',
                                          maxLines: 2,
                                          style: Theme.of(context).textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SectionHeader(
                        title: 'Thể loại',
                        onTap: () {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () => updateList('Vietnam'),
                              style: TextButton.styleFrom(
                                backgroundColor: selectedButton == 'Vietnam' ? Colors.red : Colors.white,
                              ),
                              child: Text('Vietnam'),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            TextButton(
                              onPressed: () => updateList('Quoc Te'),
                              style: TextButton.styleFrom(
                                backgroundColor: selectedButton == 'Quoc Te' ? Colors.red : Colors.white,
                              ),
                              child: Text('Quoc Te'),
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<MusicCubit, MusicState>(
                        builder: (context, state) {
                          return GridView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(top: 20),
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, mainAxisExtent: 150, mainAxisSpacing: 10, crossAxisSpacing: 10),
                            itemCount: selectedButton == 'Vietnam' ? state.vnList.length : state.interList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SongAnonymous(
                                      song: selectedButton == 'Vietnam' ? state.vnList : state.interList,
                                      index: index,
                                    ),
                                  ));
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        selectedButton == 'Vietnam' ? state.vnList[index].coverUrl ?? '' : state.interList[index].coverUrl ?? '',
                                        height: 100,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          selectedButton == 'Vietnam' ? state.vnList[index].title ?? '' : state.interList[index].title ?? '',
                                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          selectedButton == 'Vietnam'
                                              ? state.vnList[index].description ?? ''
                                              : state.interList[index].description ?? '',
                                          maxLines: 2,
                                          style: Theme.of(context).textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
