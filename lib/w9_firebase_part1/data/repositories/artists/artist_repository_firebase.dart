import 'dart:convert';

import 'package:flutter_homework/w9_firebase_part1/data/dtos/artist_dto.dart';
import 'package:flutter_homework/w9_firebase_part1/data/repositories/artists/artist_repository.dart';
import 'package:flutter_homework/w9_firebase_part1/model/artists/artist.dart';
import 'package:http/http.dart' as http;

class ArtistRepositoryFirebase implements ArtistRepository{
  final artistsUri = Uri.https(
    'w9-firebase1-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/artists.json',
  );

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of artists
      Map<String, dynamic> artistJson = json.decode(response.body);
      List<Artist> artists = [];

      for (var i in artistJson.entries) {
        artists.add(ArtistDto.fromJson(i.key, i.value));
      }

      return artists;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load artists');
    }
  }
}