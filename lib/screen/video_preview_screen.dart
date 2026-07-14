import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plantcare_app/utils/constants.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends StatefulWidget {
  final String videoPath;

  const VideoPreviewScreen({super.key, required this.videoPath});

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  late VideoPlayerController videoController;
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.file(File(widget.videoPath));
    initializeVideo();
  }

  Future<void> initializeVideo() async {
    try {
      await videoController.initialize();
    } catch (e) {
      hasError = true;
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void toggleVideo() {
    if (videoController.value.isPlaying) {
      videoController.pause();
    } else {
      videoController.play();
    }
    setState(() {});
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Preview"),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator(color: primaryColor)
            : hasError
            ? const Text(
                "Failed to load video preview.",
                style: TextStyle(color: textColor),
              )
            : AspectRatio(
                aspectRatio: videoController.value.aspectRatio,
                child: VideoPlayer(videoController),
              ),
      ),
      floatingActionButton: !isLoading && !hasError
          ? FloatingActionButton(
              onPressed: toggleVideo,
              backgroundColor: primaryColor,
              child: Icon(
                videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
