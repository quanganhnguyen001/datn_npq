import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:datn_npq/auth/model/user_model.dart';
import 'package:datn_npq/cubit/music/music_cubit.dart';
import 'package:datn_npq/models/song_model.dart';
import 'package:datn_npq/screens/favorite_screen.dart';
import 'package:datn_npq/screens/profile_screen.dart';

import 'package:datn_npq/screens/song_screen.dart';
import 'package:datn_npq/widgets/favorite_widget.dart';
import 'package:datn_npq/widgets/profile_widget.dart';
import 'package:datn_npq/widgets/ranking_widget.dart';

import 'package:datn_npq/widgets/section_header.dart';
import 'package:datn_npq/widgets/playlist_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/user/user_cubit.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key, required this.user});
  final UserModel user;

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  final CarouselController _controller = CarouselController();
  int _currentIndex = 0;
  String selectedButton = 'Vietnam';

  List<Song> _filteredItems = [];

  void filterItems(String query, List<Song> listSong) {
    if (query.isEmpty) {
      setState(() {
        _filteredItems = [];
      });
    } else {
      setState(() {
        _filteredItems = listSong.where((item) => (item.title?.toLowerCase().contains(query.toLowerCase()) ?? false)).toList();
      });
    }
  }

  @override
  void initState() {
    context.read<UserCubit>().loadUserData();
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
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final List<Widget> page = [
          _homeWidget(),
          Expanded(flex: 8, child: RankingWidget()),
          Container(),
          Expanded(
              flex: 8,
              child: FavoriteWidget(
                userModel: widget.user,
              )),
          Container(),
          Expanded(
            flex: 8,
            child: ProfileWidget(
              user: widget.user,
            ),
          ),
        ];
        return Scaffold(
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
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.deepPurple.shade800.withOpacity(0.8),
                    child: Column(
                      children: [
                        Image.asset('assets/images/tlu.png'),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                            onTap: () {
                              context.read<UserCubit>().changeIndex(0);
                            },
                            child: Text('Trang chủ')),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              context.read<UserCubit>().changeIndex(1);
                            },
                            child: Text('Bảng xếp hạng')),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Danh sách nghe gần đây',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              context.read<UserCubit>().changeIndex(3);
                            },
                            child: Text('Bài hát yêu thích')),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Playlist'),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              context.read<UserCubit>().changeIndex(5);
                            },
                            child: Text('Thông tin cá nhân')),
                      ],
                    ),
                  ),
                ),
                page[state.index]
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _homeWidget() {
    return Expanded(
      flex: 8,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Xin chào, ${widget.user.name}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Tận hưởng giai diệu yêu thích của bạn',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<MusicCubit, MusicState>(
                    builder: (context, state) {
                      return TextField(
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) => filterItems(value, state.songList),
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
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<MusicCubit, MusicState>(
                    builder: (context, state) {
                      return SizedBox(
                        child: _filteredItems.isEmpty
                            ? Container()
                            : SizedBox(
                                width: 300,
                                height: 300,
                                child: ListView.builder(
                                  itemCount: _filteredItems.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => SongScreen(
                                            song: state.songList,
                                            index: index,
                                          ),
                                        ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 15),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Image.network(
                                                state.songList[index].coverUrl ?? '',
                                                height: 100,
                                                width: 120,
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
                                      ),
                                    );
                                  },
                                ),
                              ),
                      );
                    },
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
                        return CarouselSlider.builder(
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
                            return PlaylistWidget(
                              playlist: state.playList[index],
                              user: widget.user,
                              index: index,
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
                                builder: (context) => SongScreen(
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
                                builder: (context) => SongScreen(
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
                                      selectedButton == 'Vietnam' ? state.vnList[index].description ?? '' : state.interList[index].description ?? '',
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
    );
  }
}
