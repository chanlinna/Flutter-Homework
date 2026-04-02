import 'package:flutter/material.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/model/comment/comment.dart';
import 'package:flutter_homework/w10_practice_firebase_part2/ui/theme/theme.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({super.key, required this.comment});

  final Comment comment;

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
          title: Text(comment.text),
          leading: Icon(Icons.comment, color: AppColors.iconNormal),
        ),
      ),
    );
  }
}
