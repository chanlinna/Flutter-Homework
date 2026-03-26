import 'package:flutter/material.dart';
import 'package:flutter_homework/w9_firebase_part1/data/repositories/artists/artist_repository.dart';
import 'package:flutter_homework/w9_firebase_part1/model/artists/artist.dart';
import 'package:flutter_homework/w9_firebase_part1/ui/utils/async_value.dart';

class ArtistViewModel extends ChangeNotifier {
  final ArtistRepository artistRepository;

  AsyncValue<List<Artist>> artistsValue = AsyncValue.loading();

  ArtistViewModel({required this.artistRepository}) {

    // init
    _init();
  }

  void _init() async {
    fetchArtists();
  }

  void fetchArtists() async {
    // 1- Loading state
    artistsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      List<Artist> artists = await artistRepository.fetchArtists();
      artistsValue = AsyncValue.success(artists);
    } catch (e) {
      // 3- Fetch is unsucessfull
      artistsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }
}
