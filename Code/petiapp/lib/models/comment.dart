import 'package:petiapp/models/Post.dart';
import 'package:petiapp/models/User.dart';

class Comment {
  Comment({
    required this.content,
    this.commented,
    required this.commenter,
    required this.createdAt,
    this.id,
  });

  String content;
  Post? commented;
  User commenter;
  DateTime createdAt;
  String? id;

  factory Comment.fromMap(Map<String, dynamic> json) => Comment(
        content: json["content"],
        commented:
            json["commented"] == null ? null : Post.fromMap(json["commented"]),
        commenter: User.fromMap(json["commenter"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );
}
