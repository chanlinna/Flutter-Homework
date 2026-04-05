import 'package:flutter/material.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/ui/screens/artists_v2/view_model/artist_v2_view_model.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/artist/artist_repository.dart';
import 'widgets/artist_v2_content.dart';

class ArtistV2Screen extends StatelessWidget {
  final String artistId;

  const ArtistV2Screen({super.key, required this.artistId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ArtistViewModel(repository: context.read<ArtistRepository>())
            ..fetchData(artistId),
      child: Scaffold(body: ArtistV2Content(artistId: artistId)),
    );
  }
}
