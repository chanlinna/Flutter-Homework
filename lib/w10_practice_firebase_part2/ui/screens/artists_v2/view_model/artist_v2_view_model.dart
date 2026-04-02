import 'package:flutter/material.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/data/repositories/artist/artist_repository.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/model/comment/comment.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/model/songs/song.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/ui/utils/async_value.dart';

class ArtistViewModel extends ChangeNotifier {
  final ArtistRepository repository;

  ArtistViewModel({required this.repository});

  AsyncValue<List<Song>> songsValue = AsyncValue.loading();
  AsyncValue<List<Comment>> commentsValue = AsyncValue.loading();

  Future<void> fetchData(String artistId) async {
    songsValue = AsyncValue.loading();
    commentsValue = AsyncValue.loading();
    notifyListeners();

    try {
      final songs = await repository.fetchSongArtist(artistId);
      final comments = await repository.fetchArtistComments(artistId);

      songsValue = AsyncValue.success(songs);
      commentsValue = AsyncValue.success(comments);
    } catch (e) {
      songsValue = AsyncValue.error(e);
      commentsValue = AsyncValue.error(e);
    }

    notifyListeners();
  }

  Future<void> addComment(Comment comment) async {
    try {
      final newComment = await repository.postComment(comment);

      final currentComments = commentsValue.data ?? [];
      currentComments.add(newComment);
      commentsValue = AsyncValue.success(currentComments);

      notifyListeners();
    } catch (e) {
      commentsValue = AsyncValue.error(e);
      notifyListeners();
    }
  }
}
