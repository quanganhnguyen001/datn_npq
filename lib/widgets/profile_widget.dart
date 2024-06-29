import 'package:cached_network_image/cached_network_image.dart';
import 'package:datn_npq/auth/model/user_model.dart';
import 'package:datn_npq/theme/color_paletes.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key, required this.user});
  final UserModel user;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  @override
  void initState() {
    nameController.text = widget.user.name ?? '';
    phoneController.text = widget.user.phone ?? '';
    emailController.text = widget.user.email ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Center(
            child: CachedNetworkImage(
              placeholder: (context, url) {
                return Container(
                  height: 155,
                  width: 140,
                  decoration: const BoxDecoration(color: Colors.black12, shape: BoxShape.circle),
                );
              },
              imageUrl: widget.user.imageUrl ?? '',
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
          SizedBox(
            height: 15,
          ),
          Text(
            'Tên của bạn',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 400),
            child: TextFormField(
              readOnly: true,
              controller: nameController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(190, 186, 179, 1),
                    )),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(190, 186, 179, 1),
                    )),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(190, 186, 179, 1),
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(190, 186, 179, 1),
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(190, 186, 179, 1),
                    )),
                contentPadding: EdgeInsets.only(left: 16),
                border: InputBorder.none,
                hintText: 'Tên tài khoản',
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Email của bạn',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 400),
            child: TextFormField(
              readOnly: true,
              controller: emailController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(190, 186, 179, 1),
                    )),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(190, 186, 179, 1),
                    )),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(190, 186, 179, 1),
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(190, 186, 179, 1),
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(190, 186, 179, 1),
                    )),
                contentPadding: EdgeInsets.only(left: 16),
                border: InputBorder.none,
                hintText: 'Tên tài khoản',
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'SĐT của bạn',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 400),
            child: TextFormField(
              readOnly: true,
              controller: phoneController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(190, 186, 179, 1),
                      )),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(190, 186, 179, 1),
                      )),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(190, 186, 179, 1),
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(190, 186, 179, 1),
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(190, 186, 179, 1),
                      )),
                  contentPadding: EdgeInsets.only(left: 16),
                  border: InputBorder.none,
                  hintText: 'Cap nhat so dien thoai'),
            ),
          ),
        ],
      ),
    );
  }
}
