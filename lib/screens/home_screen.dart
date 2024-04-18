import 'package:datn_npq/auth/base_screen.dart';
import 'package:datn_npq/screens/favorite_screen.dart';
import 'package:datn_npq/screens/music_screen.dart';

import 'package:datn_npq/screens/profile_screen.dart';
import 'package:datn_npq/screens/update_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/cubit/auth_cubit.dart';
import '../auth/model/user_model.dart';

import '../cubit/user/user_cubit.dart';
import '../models/playlist_model.dart';
import '../models/song_model.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(builder: (ctx) {
      return BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          List<Widget> page = [
            MusicScreen(
              user: state.user ?? const UserModel(),
            ),
            FavoriteSCreen(
                // user: userState.user ?? const UserModel(),
                ),
            ProfileScreen(
              user: state.user ?? const UserModel(),
            ),
          ];
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
                title: Text(
                  currentIndex == 0
                      ? 'Quân MP3'
                      : currentIndex == 1
                          ? 'Danh sách yêu thích'
                          : 'Thông tin tài khoản',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  GestureDetector(
                    onTap: () {
                      showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(100, 50, 0, 0),
                          items: [
                            PopupMenuItem(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => UpdateProfileScreen(
                                          user: state.user ?? UserModel())));
                                },
                                child: Text('Cập nhật thông tin tài khoản')),
                            PopupMenuItem(
                                onTap: () {
                                  context.read<AuthCubit>().logout();
                                },
                                child: Text('Đăng xuất'))
                          ]);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            (state.user ?? UserModel()).imageUrl ?? ''),
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                currentIndex: currentIndex,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.deepPurple.shade800,
                unselectedItemColor: Colors.white,
                selectedItemColor: Colors.red,
                showUnselectedLabels: false,
                showSelectedLabels: false,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_outline),
                    label: 'Favorites',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
              body: page[currentIndex],
            ),
          );
        },
      );
    });
  }
}
