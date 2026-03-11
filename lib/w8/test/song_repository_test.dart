import 'package:flutter_homework/w8/data/repositories/songs/song_repository_mock.dart';

void main() async {
  //   Instantiate the  song_repository_mock
  final songRepoMock = SongRepositoryMock();

  // Test both the success and the failure of the post request

  // Handle the Future using 2 ways  (2 tests)
  // - Using then() with .catchError().
  void testWithThenCatch() {
    songRepoMock.fetchSongById("s1")
        .then((song) {
          print("Song received ${song?.title}");
        })
        .catchError((error) {
          print(error);
        });

    songRepoMock.fetchSongById("s6")
        .then((song) {
          print("Song received ${song?.title}");
        })
        .catchError((error) {
          print(error);
        });
  }

  // - Using async/await with try/catch.
  void testWithAsyncAwait() async {
    try {
      final song = await songRepoMock.fetchSongById("s1");
      print("Song received ${song?.title}");
    } catch (error) {
      print(error);
    }

    try {
      final song = await songRepoMock.fetchSongById("s6");
      print("Song received ${song?.title}");
    } catch (error) {
      print(error);
    }
  }

  testWithThenCatch();
  testWithAsyncAwait();
}
