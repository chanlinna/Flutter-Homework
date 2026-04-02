import 'package:flutter_homework/w10_practice_firebase_part2/model/comment/comment.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/model/songs/song.dart';

import '../../../model/artist/artist.dart';

abstract class ArtistRepository {
  Future<List<Artist>> fetchArtists();

  Future<Artist?> fetchArtistById(String id);

  Future<List<Artist>> getArtists({bool forceFetch = false});

  Future<List<Song>> fetchSongArtist(String artistId);
  Future<List<Comment>> fetchArtistComments(String artistId);
  Future<Comment> postComment(Comment comment);
}
