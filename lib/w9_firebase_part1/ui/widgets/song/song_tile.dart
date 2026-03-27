import 'package:flutter/material.dart';
import 'package:flutter_homework/w9_firebase_part1/model/artists/artist.dart';

import '../../../model/songs/song.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
    required this.artist,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;
  final Artist? artist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(song.imageUrl.toString()),
          ),
          onTap: onTap,
          title: Text(song.title),
          subtitle: Text('${artist?.name}-${artist?.genre}'),
          trailing: Text(
            isPlaying ? "Playing" : "",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
