import 'package:flutter/material.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/ui/screens/artists_v2/view_model/artist_v2_view_model.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/ui/screens/artists_v2/widgets/comment_form.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/ui/screens/library/view_model/library_item_data.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/ui/screens/library/widgets/library_item_tile.dart';
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
    final state = vm.state;

    if (state.state == AsyncValueState.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.state == AsyncValueState.error) {
      return Center(
        child: Text(
          'error = ${state.error}',
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    final data = state.data!;

    final songsContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Songs", style: AppTextStyles.body),
        const SizedBox(height: 10),

        if (data.songs.isEmpty)
          const Text("No songs available")
        else
          Column(
            children: data.songs.map((song) {
              return LibraryItemTile(
                data: LibraryItemData(song: song, artist: data.artist),
                isPlaying: false,
                onTap: () {},
                onLike: () {},
              );
            }).toList(),
          ),
      ],
    );

    final commentsContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Comments", style: AppTextStyles.body),
        const SizedBox(height: 10),

        if (data.comments.isEmpty)
          const Text("No comments yet")
        else
          Column(
            children: data.comments
                .map((Comment comment) => CommentTile(comment: comment))
                .toList(),
          ),
      ],
    );

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
          CommentForm(artistId: data.artist.id),
        ],
      ),
    );
  }
}
