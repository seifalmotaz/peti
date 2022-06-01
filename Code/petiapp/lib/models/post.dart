import 'location.dart';
import 'pet.dart';

class Post {
  Post({
    this.file,
    this.content,
    this.createdAt,
    this.id,
    this.likes,
    this.comments,
    this.creator,
    this.isLiked,
    this.location,
  });

  FileObject? file;
  dynamic content;
  String? createdAt;
  String? id;
  int? likes;
  bool? isLiked;
  int? comments;
  Pet? creator;
  Location? location;

  bool isDeleted = false;

  factory Post.fromMap(Map<String, dynamic> json) => Post(
        file: FileObject.fromMap(json["file"]),
        content: json["content"],
        isLiked: json["is_liked"],
        createdAt: json["created_at"],
        id: json["id"],
        likes: json["likes"],
        comments: json["comments"],
        location: json["location"] == null
            ? null
            : Location.fromMap(json["location"]),
        creator: json["creator"] == null ? null : Pet.fromMap(json["creator"]),
      );
}

class FileObject {
  FileObject({
    required this.url,
    this.bgcolor,
    this.thumbinal,
    required this.mimetype,
  });

  String url;
  String? bgcolor;
  String? thumbinal;
  String mimetype;

  factory FileObject.fromMap(Map<String, dynamic> json) => FileObject(
        url: json["url"],
        bgcolor: json['bgcolor'],
        thumbinal: json["thumbinal"],
        mimetype: json["mimetype"],
      );

  bool get isVideo => mimetype.startsWith('video');
}
