import 'package:flutter/material.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/model/songs/song.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/ui/screens/artists_v2/view_model/artist_v2_view_model.dart';
import 'package:provider/provider.dart';
import '../../../../model/comment/comment.dart';
import '../../../theme/theme.dart';
import '../../../utils/async_value.dart';
import 'comment_tile.dart';

class ArtistV2Content extends StatelessWidget {
  final String artistId;

  const ArtistV2Content({super.key, required this.artistId});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ArtistViewModel>();

    Widget songsContent;
    switch (vm.songsValue.state) {
      case AsyncValueState.loading:
        songsContent = const Center(child: CircularProgressIndicator());
        break;

      case AsyncValueState.error:
        songsContent = Center(
          child: Text(
            'error = ${vm.songsValue.error!}',
            style: const TextStyle(color: Colors.red),
          ),
        );
        break;

      case AsyncValueState.success:
        final List<Song> songs = vm.songsValue.data!;

        songsContent = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Songs", style: AppTextStyles.body),
            const SizedBox(height: 10),

            if (songs.isEmpty)
              const Text("No songs available")
            else
              Expanded(
                child: ListView.builder(
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    final song = songs[index];
                    return ListTile(
                      leading: const Icon(Icons.music_note),
                      title: Text(song.title),
                      subtitle: Text("${song.duration.inMinutes} min"),
                    );
                  },
                ),
              ),
          ],
        );
    }

    Widget commentsContent;
    switch (vm.commentsValue.state) {
      case AsyncValueState.loading:
        commentsContent = const Center(child: CircularProgressIndicator());
        break;

      case AsyncValueState.error:
        commentsContent = Center(
          child: Text(
            'error = ${vm.commentsValue.error!}',
            style: const TextStyle(color: Colors.red),
          ),
        );
        break;

      case AsyncValueState.success:
        final List<Comment> comments = vm.commentsValue.data!;

        commentsContent = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Comments", style: AppTextStyles.body),
            const SizedBox(height: 10),

            if (comments.isEmpty)
              const Text("No comments yet")
            else
              Expanded(
                child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return CommentTile(comment: comments[index]);
                  },
                ),
              ),
          ],
        );
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(height: 16),

          Text("Artist Detail", style: AppTextStyles.heading),
          const SizedBox(height: 30),

          Expanded(
            child: ListView(
              children: [
                songsContent,
                const SizedBox(height: 30),
                commentsContent,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
