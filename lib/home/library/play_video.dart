import 'package:flutter/material.dart';
import 'package:appinio_video_player/appinio_video_player.dart';

class PlayVideo extends StatefulWidget {
  const PlayVideo({super.key, required this.videoURL, required this.videoName});
  final String videoURL;
  final String videoName;

  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer(
      widget.videoURL,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.videoName)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomVideoPlayer(
              customVideoPlayerController: _customVideoPlayerController,
            ),
          ],
        ));
  }

  void initializeVideoPlayer(String videoUrl) {
    CachedVideoPlayerController videoPlayerController;
    videoPlayerController = CachedVideoPlayerController.network(videoUrl)
      ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }
}