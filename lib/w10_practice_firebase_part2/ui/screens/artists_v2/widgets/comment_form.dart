import 'package:flutter/material.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/model/comment/comment.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/ui/screens/artists_v2/view_model/artist_v2_view_model.dart';
import 'package:provider/provider.dart';

class CommentForm extends StatefulWidget {
  final String artistId;

  const CommentForm({super.key, required this.artistId});

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final TextEditingController _controller = TextEditingController();

  void _submit() {
    final text = _controller.text.trim();

    if (text.isEmpty) return;

    context.read<ArtistViewModel>().addComment(
      Comment(id: '', artistId: widget.artistId, text: text),
    );

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "comment",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(icon: const Icon(Icons.send), onPressed: _submit),
        ],
      ),
    );
  }
}
