import 'dart:convert';

import 'package:flutter_homework/w10_practice_firebase_part2/config/firebase_config.dart';
import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  final Uri songsUri = FirebaseConfig.baseUri.replace(path: '/songs.json');
  List<Song>? _cachedSongs;

  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);

      List<Song> result = [];
      for (final entry in songJson.entries) {
        result.add(SongDto.fromJson(entry.key, entry.value));
      }
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<List<Song>> getSongs({bool forceFetch = false}) async {
    if (_cachedSongs != null && !forceFetch) {
      return _cachedSongs!;
    }

    final songs = await fetchSongs();

    _cachedSongs = songs;

    return songs;
  }

  void clearCache() {
    _cachedSongs = null;
  }

  @override
  Future<Song?> fetchSongById(String id) async {}

  @override
  Future<void> likeSong(String id, int likeCount) async {
    final Uri songUri = FirebaseConfig.baseUri.replace(path: '/songs/$id.json');

    try {
      final response = await http.patch(
        songUri,
        body: json.encode({'likes': likeCount + 1}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update likes');
      }
    } catch (e) {
      throw Exception('Failed to patch like count: $e');
    }
  }
}