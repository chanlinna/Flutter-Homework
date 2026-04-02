import 'package:flutter/material.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/ui/screens/artists_v2/artist_v2_screen.dart';
import '../../../model/artist/artist.dart';

class ArtistTile extends StatelessWidget {
  const ArtistTile({
    super.key,
    required this.artist,
    
  });

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          title: Text(artist.name),
          subtitle: Text("Genre: ${artist.genre}"),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(artist.imageUrl.toString()),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ArtistV2Screen(artistId: artist.id),
              ),
            );
          },
        ),
      ),
    );
  }
}
