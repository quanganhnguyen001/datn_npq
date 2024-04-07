import 'package:cached_network_image/cached_network_image.dart';
import 'package:datn_npq/auth/model/user_model.dart';
import 'package:flutter/material.dart';

import '../theme/color_paletes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
        child: Center(
          child: Column(
            children: [
              Center(
                child: CachedNetworkImage(
                  placeholder: (context, url) {
                    return Container(
                      height: 155,
                      width: 140,
                      decoration: const BoxDecoration(
                          color: Colors.black12, shape: BoxShape.circle),
                    );
                  },
                  imageUrl: user.imageUrl ?? '',
                  imageBuilder: (context, imageProvider) => Container(
                    height: 155,
                    width: 140,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color: ColorPalettes.secondaryColor,
                      ),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 155,
                    width: 140,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color: ColorPalettes.secondaryColor,
                      ),
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                          image: NetworkImage(
                              'https://media.istockphoto.com/id/1223671392/vi/vec-to/%E1%BA%A3nh-h%E1%BB%93-s%C6%A1-m%E1%BA%B7c-%C4%91%E1%BB%8Bnh-h%C3%ACnh-%C4%91%E1%BA%A1i-di%E1%BB%87n-ch%E1%BB%97-d%C3%A0nh-s%E1%BA%B5n-cho-%E1%BA%A3nh-minh-h%E1%BB%8Da-vect%C6%A1.jpg?s=612x612&w=0&k=20&c=l9x3h9RMD16-z4kNjo3z7DXVEORzkxKCMn2IVwn9liI=')),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(user.name ?? ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(user.email ?? ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(user.phone != ""
                      ? (user.phone ?? '')
                      : 'Cập nhật số điện thoại'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
