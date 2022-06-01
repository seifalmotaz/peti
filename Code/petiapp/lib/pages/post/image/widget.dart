import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:petiapp/models/post.dart';
import 'package:petiapp/pages/post/widgets/actions_corner.dart';
import 'package:petiapp/pages/post/widgets/info_corner.dart';

class PostImageWidget extends StatefulWidget {
  final Post post;
  final Function delete;
  final Function like;
  const PostImageWidget(
    this.post, {
    required this.like,
    required this.delete,
    Key? key,
  }) : super(key: key);

  @override
  State<PostImageWidget> createState() => _PostImageWidgetState();
}

class _PostImageWidgetState extends State<PostImageWidget> {
  bool isLiked = false;
  bool wantToDelete = false;

  @override
  void initState() {
    isLiked = widget.post.isLiked!;
    super.initState();
  }

  setData(bool likeit, wantdelete) => setState(() {
        isLiked = likeit;
        wantToDelete = wantdelete;
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () async {
        bool? data = await widget.like();
        if (data != null) {
          setState(() {
            isLiked = data;
          });
        }
      },
      child: Container(
        color: fromCssColor(widget.post.file!.bgcolor ?? "#000000"),
        child: Stack(
          children: [
            SizedBox.expand(
              child: Opacity(
                opacity: .3,
                child: CachedNetworkImage(
                  imageUrl: widget.post.file!.url,
                  placeholder: (_, __) => const Center(
                    child: SpinKitRing(
                      color: Colors.white,
                      lineWidth: 5,
                      size: 27,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageBuilder: (context, imageProvider) {
                    return ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        colorBlendMode: BlendMode.overlay,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox.expand(
              child: CachedNetworkImage(
                imageUrl: widget.post.file!.url,
                placeholder: (_, __) => const Center(
                  child: SpinKitRing(
                    color: Colors.white,
                    lineWidth: 5,
                    size: 27,
                  ),
                ),
                imageBuilder: (context, imageProvider) {
                  return Image(
                    image: imageProvider,
                    fit: BoxFit.fitWidth,
                  );
                },
              ),
            ),
            InfoCorner(widget.post),
            ActionsCorner(
              setData: setData,
              post: widget.post,
              like: widget.like,
              delete: widget.delete,
              isLiked: isLiked,
              wantToDelete: wantToDelete,
            ),
          ],
        ),
      ),
    );
  }
}
