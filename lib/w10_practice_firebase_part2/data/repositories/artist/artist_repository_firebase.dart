import 'dart:convert';

import 'package:flutter_homework/w10_practice_firebase_part2/config/firebase_config.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/data/dtos/comment_dto.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/data/dtos/song_dto.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/model/comment/comment.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/model/songs/song.dart';
import 'package:http/http.dart' as http;

import '../../../model/artist/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase implements ArtistRepository {
  final Uri artistsUri = FirebaseConfig.baseUri.replace(path: '/artists.json');
  final Uri commentsUri = FirebaseConfig.baseUri.replace(
    path: '/comments.json',
  );
  final Uri songsUri = FirebaseConfig.baseUri.replace(path: '/songs.json');
  List<Artist>? _cachedArtists;

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);

      List<Artist> result = [];
      for (final entry in songJson.entries) {
        result.add(ArtistDto.fromJson(entry.key, entry.value));
      }
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Artist?> fetchArtistById(String artistId) async {
    final Uri artistUri = FirebaseConfig.baseUri.replace(
      path: '/artists/$artistId.json',
    );
    final http.Response response = await http.get(artistUri);
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      if (decoded == null) return null;

      return ArtistDto.fromJson(artistId, decoded);
    } else {
      throw Exception('failed to fetch artist with id $artistId');
    }
  }

  @override
  Future<List<Artist>> getArtists({bool forceFetch = false}) async {
    if (!forceFetch && _cachedArtists != null) {
      return _cachedArtists!;
    }

    final List<Artist> artists = await fetchArtists();
    _cachedArtists = artists;

    return artists;
  }

  @override
  Future<List<Song>> fetchSongArtist(String artistId) async {
    final response = await http.get(songsUri);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      if (decoded == null) return [];

      Map<String, dynamic> songData = decoded;
      List<Song> result = [];

      for (final entry in songData.entries) {
        final song = SongDto.fromJson(entry.key, entry.value);
        if (song.artistId == artistId) {
          result.add(song);
        }
      }

      return result;
    } else {
      throw Exception('Failed to fetch song(s) of $artistId');
    }
  }

  @override
  Future<List<Comment>> fetchArtistComments(String artistId) async {
    final response = await http.get(commentsUri);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      if (decoded == null) return [];

      Map<String, dynamic> commentData = decoded;
      List<Comment> result = [];

      for (final entry in commentData.entries) {
        final comment = CommentDto.fromJson(entry.key, entry.value);
        if (comment.artistId == artistId) {
          result.add(comment);
        }
      }

      return result;
    } else {
      throw Exception('Failed to fetch comment(s) of $artistId');
    }
  }

  @override
  Future<Comment> postComment(Comment comment) async {
    final commentDto = CommentDto();
    final response = await http.post(
      commentsUri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(commentDto.toJson(comment)),
    );

    final id = json.decode(response.body)['name'];

    return Comment(id: id, artistId: comment.artistId, text: comment.text);
  }
}
