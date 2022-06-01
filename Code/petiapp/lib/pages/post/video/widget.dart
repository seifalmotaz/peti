import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:petiapp/models/post.dart';
import 'package:petiapp/pages/post/widgets/actions_corner.dart';
import 'package:petiapp/pages/post/widgets/info_corner.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PostVideoWidget extends StatefulWidget {
  final Post post;
  final Function delete;
  final Function like;
  const PostVideoWidget(this.post,
      {required this.like, required this.delete, Key? key})
      : super(key: key);

  @override
  State<PostVideoWidget> createState() => _PostVideoWidgetState();
}

class _PostVideoWidgetState extends State<PostVideoWidget> {
  late Post post;
  VideoPlayerController? videoController;
  bool playIt = true;
  bool isLiked = false;
  bool wantToDelete = false;

  setData(bool likeit, wantdelete) => setState(() {
        isLiked = likeit;
        wantToDelete = wantdelete;
      });

  @override
  void initState() {
    isLiked = widget.post.isLiked!;
    videoController = VideoPlayerController.network(widget.post.file!.url);
    super.initState();
    post = widget.post;
    videoController!.setLooping(true);
    videoController!.initialize().then((value) => setState(() {}));
  }

  @override
  void dispose() {
    videoController!.dispose();
    super.dispose();
  }

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
        color: fromCssColor(widget.post.file!.bgcolor!),
        child: GestureDetector(
          onTap: () {
            setState(() {
              playIt ? videoController!.pause() : videoController!.play();
              playIt = !playIt;
            });
          },
          child: VisibilityDetector(
            key: UniqueKey(),
            onVisibilityChanged: (info) {
              if (mounted) {
                if (info.visibleFraction >= .9) {
                  if (playIt &&
                      videoController != null &&
                      !videoController!.value.isPlaying) {
                    videoController!.play();
                  }
                } else {
                  videoController!.pause();
                }
              }
            },
            child: Stack(
              children: [
                SizedBox.expand(
                  child: Opacity(
                    opacity: .3,
                    child: CachedNetworkImage(
                      imageUrl: post.file!.thumbinal!,
                      placeholder: (_, __) => const Center(
                        child: SpinKitRing(
                          color: Colors.white,
                          lineWidth: 5,
                          size: 27,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
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
                if (videoController!.value.isInitialized)
                  Center(
                    child: AspectRatio(
                      aspectRatio: videoController!.value.aspectRatio,
                      child: VideoPlayer(videoController!),
                    ),
                  ),
                Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    switchInCurve: Curves.easeInCubic,
                    switchOutCurve: Curves.easeInCubic,
                    child: playIt
                        ? null
                        : const Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 61,
                          ),
                  ),
                ),
                InfoCorner(widget.post),
                ActionsCorner(
                  setData: setData,
                  post: widget.post,
                  like: widget.like(),
                  delete: widget.delete,
                  isLiked: isLiked,
                  wantToDelete: wantToDelete,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
