import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn_npq/screens/playlist_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/playlist_model.dart';

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({
    Key? key,
    required this.playlist,
    required this.onTap,
    this.onPressed,
    this.onPressedEdit,
  }) : super(key: key);

  final Playlist playlist;
  final Function() onTap;
  final Function()? onPressed;
  final Function()? onPressedEdit;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 75,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade800.withOpacity(0.6),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                playlist.imageUrl ?? '',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    playlist.title ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${playlist.songs?.length} songs',
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            FirebaseAuth.instance.currentUser == null
                ? IconButton(
                    onPressed: onPressedEdit,
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                  )
                : Container(),
            FirebaseAuth.instance.currentUser == null
                ? IconButton(
                    onPressed: onPressed,
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
