import 'package:flutter/material.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/data/repositories/artist/artist_repository.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/model/comment/comment.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/ui/screens/artists_v2/view_model/artist_item_data.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/ui/utils/async_value.dart';

class ArtistViewModel extends ChangeNotifier {
  final ArtistRepository repository;

  ArtistViewModel({required this.repository});

  AsyncValue<ArtistItemData> state = AsyncValue.loading();

  Future<void> fetchData(String artistId) async {
    state = AsyncValue.loading();
    notifyListeners();

    try {
      final artist = await repository.fetchArtistById(artistId);
      final songs = await repository.fetchSongArtist(artistId);
      final comments = await repository.fetchArtistComments(artistId);

      state = AsyncValue.success(
        ArtistItemData(artist: artist!, songs: songs, comments: comments),
      );
    } catch (e) {
      state = AsyncValue.error(e);
    }

    notifyListeners();
  }
  
  Future<void> addComment(Comment comment) async {
    try {
      await repository.postComment(comment);

      final updatedComments = await repository.fetchArtistComments(
        comment.artistId,
      );

      state = AsyncValue.success(
        ArtistItemData(
          artist: state.data!.artist,
          songs: state.data!.songs,
          comments: updatedComments,
        ),
      );

      notifyListeners();
    } catch (e) {
      state = AsyncValue.error(e);
      notifyListeners();
    }
  }
}
