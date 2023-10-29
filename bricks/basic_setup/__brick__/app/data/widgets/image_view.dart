import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ImageView<T> extends StatelessWidget {
  const ImageView({
    Key? key,
    required this.imagePaths,
    required this.selectedImage,
  }) : super(key: key);
  final List<T> imagePaths;
  final int selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselSlider(
                items:
                    imagePaths.map((e) => _ImageBuilder<T>(image: e)).toList(),
                options: CarouselOptions(
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? Get.height * 0.8
                          : Get.height * 0.75,
                  viewportFraction: 1,
                  initialPage: selectedImage,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageBuilder<T> extends StatefulWidget {
  const _ImageBuilder({Key? key, required this.image}) : super(key: key);
  final T image;

  @override
  State<_ImageBuilder> createState() => __ImageBuilderState();
}

class __ImageBuilderState extends State<_ImageBuilder>
    with SingleTickerProviderStateMixin {
  late TransformationController controller;
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TransformationController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() => controller.value = animation!.value);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.image.isVideo) {
      log(widget.image.url);
    }
    return widget.image.isVideo
        ? FractionallySizedBox(
            widthFactor: 0.99,
            child: _VideoBuilder(videoUrl: widget.image.url),
          )
        : InteractiveViewer(
            onInteractionEnd: (details) => resetAnimation(),
            transformationController: controller,
            minScale: 1,
            maxScale: 4,
            panEnabled: false,
            child: FractionallySizedBox(
              widthFactor: 0.99,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    // image: ImageUtil.imageFromBase64String(
                    //   widget.image.imagePath,
                    // ),
                    image: NetworkImage(widget.image.url),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    animationController.dispose();
  }

  void resetAnimation() {
    animation =
        Matrix4Tween(begin: controller.value, end: Matrix4.identity()).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOutCubic,
      ),
    );
    animationController.forward(from: 0);
  }
}

// ignore: must_be_immutable
class _VideoBuilder extends StatefulWidget {
  _VideoBuilder({required this.videoUrl});

  String videoUrl;

  @override
  _VideoBuilderState createState() => _VideoBuilderState();
}

class _VideoBuilderState extends State<_VideoBuilder> {
  late VideoPlayerController _controller;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: GestureDetector(
                onTap: () {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                    setState(() {
                      isPlaying = false;
                    });
                  } else {
                    _controller.play();
                    setState(() {
                      isPlaying = true;
                    });
                  }
                },
                child: Stack(
                  children: [
                    VideoPlayer(_controller),
                    if (isPlaying)
                      const SizedBox.shrink()
                    else
                      Positioned(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4,
                            ),
                            child: VideoProgressIndicator(
                              _controller,
                              colors: const VideoProgressColors(
                                playedColor: Colors.grey,
                                bufferedColor: Colors.white,
                                backgroundColor: Colors.black,
                              ),
                              allowScrubbing: true,
                            ),
                          ),
                        ),
                      ),
                    if (isPlaying)
                      const SizedBox.shrink()
                    else
                      const Positioned(
                        child: Align(
                          child: Icon(
                            Icons.play_arrow_rounded,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            )
          : Container(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
