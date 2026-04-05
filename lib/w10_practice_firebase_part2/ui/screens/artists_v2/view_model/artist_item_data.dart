import 'package:flutter_homework/w10_practice_firebase_part2/model/artist/artist.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/model/comment/comment.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/model/songs/song.dart';

class ArtistItemData {
  final Artist artist;
  final List<Song> songs;
  final List<Comment> comments;

  ArtistItemData({
    required this.artist,
    required this.songs,
    required this.comments,
  });
}
