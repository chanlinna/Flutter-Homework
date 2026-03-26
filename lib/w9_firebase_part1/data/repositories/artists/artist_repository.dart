import 'package:flutter_homework/w9_firebase_part1/model/artists/artist.dart';

abstract class ArtistRepository {
  Future<List<Artist>> fetchArtists();
}