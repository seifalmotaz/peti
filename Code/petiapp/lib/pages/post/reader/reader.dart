import 'package:flutter/material.dart';
import 'package:petiapp/models/post.dart';
import 'package:petiapp/pages/post/image/widget.dart';
import 'package:petiapp/pages/post/video/widget.dart';

class PostReader extends StatelessWidget {
  final Post post;
  final Function like;
  final Function delete;
  const PostReader(
    this.post, {
    Key? key,
    required this.like,
    required this.delete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isVideo = post.file!.isVideo;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: isVideo
          ? PostVideoWidget(
              post,
              like: () {},
              delete: () {},
            )
          : PostImageWidget(
              post,
              like: () => like(),
              delete: () => delete(),
            ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
          opacity: .81,
        ),
      ),
    );
  }
}
